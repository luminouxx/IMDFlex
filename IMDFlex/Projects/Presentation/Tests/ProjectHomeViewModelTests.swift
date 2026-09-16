import Foundation
import XCTest
import Domain
@testable import Presentation

@MainActor
final class ProjectHomeViewModelTests: XCTestCase {
    func test_whenViewModelIsCreated_thenItStartsIdleWithoutRequestingProjects() async {
        // Given
        let (sut, service) = makeSUT()

        // When
        let loadProjectsCallCount = await service.loadProjectsCallCount

        // Then
        XCTAssertEqual(sut.loadState, .idle)
        XCTAssertTrue(sut.projects.isEmpty)
        XCTAssertNil(sut.alert)
        XCTAssertNil(sut.route)
        XCTAssertEqual(loadProjectsCallCount, 0)
    }

    func test_whenProjectsLoadSuccessfully_thenTheyAreDisplayedMostRecentlyUpdatedFirst() async {
        // Given
        let olderProject = makeProject(name: "Older", updatedAt: 100)
        let newerProject = makeProject(name: "Newer", updatedAt: 200)
        let (sut, _) = makeSUT(loadResponses: [.success([olderProject, newerProject])])

        // When
        await sut.loadIfNeeded()

        // Then
        XCTAssertEqual(sut.loadState, .loaded)
        XCTAssertEqual(sut.projects.map(\.id), [newerProject.id, olderProject.id])
        XCTAssertNil(sut.alert)
    }

    func test_whenNoProjectsExist_thenLoadingCompletesWithAnEmptyCollection() async {
        // Given
        let (sut, _) = makeSUT(loadResponses: [.success([])])

        // When
        await sut.loadIfNeeded()

        // Then
        XCTAssertEqual(sut.loadState, .loaded)
        XCTAssertTrue(sut.projects.isEmpty)
    }

    func test_whenInitialLoadingFails_thenFailureStateOffersRetry() async {
        // Given
        let (sut, _) = makeSUT(loadResponses: [.failure])

        // When
        await sut.loadIfNeeded()

        // Then
        XCTAssertEqual(sut.loadState, .failed)
        XCTAssertEqual(sut.alert, .loadingFailed)
        XCTAssertTrue(sut.projects.isEmpty)
    }

    func test_whenRetrySucceeds_thenFailureIsClearedAndProjectsAreReplaced() async {
        // Given
        let recoveredProject = makeProject(name: "Recovered", updatedAt: 300)
        let (sut, _) = makeSUT(loadResponses: [
            .failure,
            .success([recoveredProject])
        ])
        await sut.loadIfNeeded()

        // When
        await sut.retryLoading()

        // Then
        XCTAssertEqual(sut.loadState, .loaded)
        XCTAssertNil(sut.alert)
        XCTAssertEqual(sut.projects.map(\.id), [recoveredProject.id])
    }

    func test_whenLoadIfNeededIsCalledAfterSuccessfulLoading_thenProjectsAreNotRequestedAgain() async {
        // Given
        let (sut, service) = makeSUT(loadResponses: [.success([])])
        await sut.loadIfNeeded()

        // When
        await sut.loadIfNeeded()
        let loadProjectsCallCount = await service.loadProjectsCallCount

        // Then
        XCTAssertEqual(loadProjectsCallCount, 1)
    }

    func test_whenProjectNameContainsOnlyWhitespace_thenCreationIsDisabled() {
        // Given
        let (sut, _) = makeSUT()

        // When
        sut.newProjectName = "   \n"

        // Then
        XCTAssertFalse(sut.canCreateProject)
    }

    func test_whenProjectNameContainsVisibleCharacters_thenCreationIsEnabled() {
        // Given
        let (sut, _) = makeSUT()

        // When
        sut.newProjectName = "  Suwon Convention Center  "

        // Then
        XCTAssertTrue(sut.canCreateProject)
    }

    func test_whenBlankProjectNameIsSubmitted_thenValidationFailsWithoutCallingService() async {
        // Given
        let (sut, service) = makeSUT()
        sut.newProjectName = "   "

        // When
        await sut.createProject()
        let createProjectCallCount = await service.createProjectCallCount

        // Then
        XCTAssertEqual(sut.alert, .invalidProjectName)
        XCTAssertEqual(createProjectCallCount, 0)
        XCTAssertNil(sut.route)
    }

    func test_whenProjectIsCreated_thenTrimmedNameIsSavedAndWorkspaceRouteIsSelected() async {
        // Given
        let createdProject = makeProject(name: "Suwon Convention Center", updatedAt: 300)
        let (sut, service) = makeSUT(createResponse: .success(createdProject))
        sut.newProjectName = "  Suwon Convention Center  "

        // When
        await sut.createProject()
        let receivedNames = await service.receivedProjectNames

        // Then
        XCTAssertEqual(receivedNames, ["Suwon Convention Center"])
        XCTAssertEqual(sut.projects.map(\.id), [createdProject.id])
        XCTAssertEqual(sut.route, .workspace(projectID: createdProject.id))
        XCTAssertEqual(sut.newProjectName, "")
        XCTAssertNil(sut.alert)
    }

    func test_whenProjectCreationFails_thenFailureIsPresentedWithoutChangingProjectsOrRoute() async {
        // Given
        let existingProject = makeProject(name: "Existing", updatedAt: 100)
        let (sut, _) = makeSUT(
            loadResponses: [.success([existingProject])],
            createResponse: .failure
        )
        await sut.loadIfNeeded()
        sut.newProjectName = "New Project"

        // When
        await sut.createProject()

        // Then
        XCTAssertEqual(sut.alert, .creationFailed)
        XCTAssertEqual(sut.projects.map(\.id), [existingProject.id])
        XCTAssertNil(sut.route)
        XCTAssertEqual(sut.newProjectName, "New Project")
    }

    func test_whenCreationIsAlreadyInProgress_thenDuplicateSubmissionIsIgnored() async {
        // Given
        let createdProject = makeProject(name: "Project", updatedAt: 100)
        let service = SuspendingProjectHomeServiceSpy(createdProject: createdProject)
        let sut = ProjectHomeViewModel(service: service)
        sut.newProjectName = "Project"

        // When
        let firstSubmission = Task { await sut.createProject() }
        let creationDidStart = await waitUntilCreationStarts(in: service)

        guard creationDidStart else {
            XCTFail("Expected the first creation request to reach the service")
            await firstSubmission.value
            return
        }

        let duplicateSubmission = Task { await sut.createProject() }
        await Task.yield()
        let createProjectCallCount = await service.createProjectCallCount
        await service.completeCreation()
        await firstSubmission.value
        await duplicateSubmission.value

        // Then
        XCTAssertEqual(createProjectCallCount, 1)
    }

    func test_whenProjectIsOpened_thenWorkspaceRouteContainsSelectedProjectID() {
        // Given
        let project = makeProject(name: "Project", updatedAt: 100)
        let (sut, _) = makeSUT()

        // When
        sut.openProject(projectID: project.id)

        // Then
        XCTAssertEqual(sut.route, .workspace(projectID: project.id))
    }

    func test_whenDeletionIsRequested_thenSelectedProjectAwaitsConfirmation() async {
        // Given
        let project = makeProject(name: "Project", updatedAt: 100)
        let (sut, service) = makeSUT(loadResponses: [.success([project])])
        await sut.loadIfNeeded()

        // When
        sut.requestDeletion(projectID: project.id)
        let deleteProjectCallCount = await service.deleteProjectCallCount

        // Then
        XCTAssertEqual(sut.pendingDeletionID, project.id)
        XCTAssertEqual(deleteProjectCallCount, 0)
    }

    func test_whenDeletionIsCancelled_thenProjectRemainsAndServiceIsNotCalled() async {
        // Given
        let project = makeProject(name: "Project", updatedAt: 100)
        let (sut, service) = makeSUT(loadResponses: [.success([project])])
        await sut.loadIfNeeded()
        sut.requestDeletion(projectID: project.id)

        // When
        sut.cancelDeletion()
        let deleteProjectCallCount = await service.deleteProjectCallCount

        // Then
        XCTAssertNil(sut.pendingDeletionID)
        XCTAssertEqual(sut.projects.map(\.id), [project.id])
        XCTAssertEqual(deleteProjectCallCount, 0)
    }

    func test_whenDeletionIsConfirmed_thenProjectIsRemovedAfterServiceSucceeds() async {
        // Given
        let project = makeProject(name: "Project", updatedAt: 100)
        let (sut, service) = makeSUT(loadResponses: [.success([project])])
        await sut.loadIfNeeded()
        sut.requestDeletion(projectID: project.id)

        // When
        await sut.confirmDeletion()
        let receivedDeletionIDs = await service.receivedDeletionIDs

        // Then
        XCTAssertEqual(receivedDeletionIDs, [project.id])
        XCTAssertTrue(sut.projects.isEmpty)
        XCTAssertNil(sut.pendingDeletionID)
        XCTAssertNil(sut.alert)
    }

    func test_whenDeletionFails_thenProjectAndPendingConfirmationArePreservedForRecovery() async {
        // Given
        let project = makeProject(name: "Project", updatedAt: 100)
        let (sut, _) = makeSUT(
            loadResponses: [.success([project])],
            deleteResponse: .failure
        )
        await sut.loadIfNeeded()
        sut.requestDeletion(projectID: project.id)

        // When
        await sut.confirmDeletion()

        // Then
        XCTAssertEqual(sut.alert, .deletionFailed)
        XCTAssertEqual(sut.projects.map(\.id), [project.id])
        XCTAssertEqual(sut.pendingDeletionID, project.id)
    }

    func test_whenSearchQueryMatchesLocalizedProjectName_thenOnlyMatchingProjectsAreVisible() async {
        // Given
        let suwonProject = makeProject(name: "수원컨벤션센터", updatedAt: 200)
        let junctionProject = makeProject(name: "JunctionX Hall", updatedAt: 100)
        let (sut, _) = makeSUT(loadResponses: [.success([junctionProject, suwonProject])])
        await sut.loadIfNeeded()

        // When
        sut.searchQuery = "컨벤션"

        // Then
        XCTAssertEqual(sut.filteredProjects.map(\.id), [suwonProject.id])
    }

    private func makeSUT(
        loadResponses: [ProjectHomeServiceSpy.LoadResponse] = [.success([])],
        createResponse: ProjectHomeServiceSpy.CreateResponse = .failure,
        deleteResponse: ProjectHomeServiceSpy.DeleteResponse = .success
    ) -> (sut: ProjectHomeViewModel, service: ProjectHomeServiceSpy) {
        let service = ProjectHomeServiceSpy(
            loadResponses: loadResponses,
            createResponse: createResponse,
            deleteResponse: deleteResponse
        )
        let sut = ProjectHomeViewModel(service: service)

        return (sut, service)
    }

    private func makeProject(
        name: String,
        updatedAt: TimeInterval
    ) -> IMDFProject {
        IMDFProject(
            name: name,
            createdAt: Date(timeIntervalSince1970: updatedAt - 10),
            updatedAt: Date(timeIntervalSince1970: updatedAt)
        )
    }

    private func waitUntilCreationStarts(
        in service: SuspendingProjectHomeServiceSpy,
        maximumAttempts: Int = 200
    ) async -> Bool {
        for _ in 0..<maximumAttempts {
            if await service.createProjectCallCount > 0 {
                return true
            }

            await Task.yield()
        }

        return false
    }
}
