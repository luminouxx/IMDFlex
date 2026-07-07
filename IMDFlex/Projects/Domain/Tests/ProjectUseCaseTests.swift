import Foundation
import XCTest
@testable import Domain

final class ProjectUseCaseTests: XCTestCase {
    func test_whenProjectIsCreated_thenItIsSavedThroughRepositoryProtocol() async throws {
        // Given
        let (sut, repository) = makeSUT()

        // When
        let project = try await sut.createProject(name: "Indoor Mapping")
        let savedProject = try await repository.fetch(id: project.id)

        // Then
        XCTAssertEqual(savedProject?.id, project.id)
        XCTAssertEqual(savedProject?.name, "Indoor Mapping")
        XCTAssertNil(savedProject?.venue)
    }

    func test_whenProjectsAreLoaded_thenRepositoryProjectsAreReturned() async throws {
        // Given
        let (sut, repository) = makeSUT()
        let firstProject = IMDFProject(name: "First Project")
        let secondProject = IMDFProject(name: "Second Project")

        try await repository.save(firstProject)
        try await repository.save(secondProject)

        // When
        let projects = try await sut.loadProjects()
        let projectIDs = Set(projects.map(\.id))

        // Then
        XCTAssertEqual(projectIDs, [firstProject.id, secondProject.id])
    }

    func test_whenProjectIsUpdated_thenUpdatedAtIsRefreshedAndContentIsPreserved() async throws {
        // Given
        let (sut, repository) = makeSUT()
        let createdAt = Date(timeIntervalSince1970: 100)
        let oldUpdatedAt = Date(timeIntervalSince1970: 200)
        let venue = Venue(name: "Venue", category: .university)
        let project = IMDFProject(
            name: "Project",
            venue: venue,
            createdAt: createdAt,
            updatedAt: oldUpdatedAt
        )

        // When
        try await sut.updateProject(project)

        // Then
        let fetchedProject = try await repository.fetch(id: project.id)
        let updatedProject = try XCTUnwrap(fetchedProject)
        XCTAssertEqual(updatedProject.id, project.id)
        XCTAssertEqual(updatedProject.name, project.name)
        XCTAssertEqual(updatedProject.venue?.id, venue.id)
        XCTAssertEqual(updatedProject.createdAt, createdAt)
        XCTAssertGreaterThan(updatedProject.updatedAt, oldUpdatedAt)
    }

    func test_whenProjectIsDeleted_thenItIsRemovedThroughRepositoryProtocol() async throws {
        // Given
        let (sut, repository) = makeSUT()
        let project = IMDFProject(name: "Project To Delete")
        try await repository.save(project)

        // When
        try await sut.deleteProject(id: project.id)
        let deletedProject = try await repository.fetch(id: project.id)

        // Then
        XCTAssertNil(deletedProject)
    }

    private func makeSUT() -> (sut: ProjectUseCase, repository: InMemoryProjectRepositoryFake) {
        let repository = InMemoryProjectRepositoryFake()
        let sut = ProjectUseCase(repository: repository)

        return (sut, repository)
    }
}

private actor InMemoryProjectRepositoryFake: ProjectRepositoryProtocol {
    private var projects: [UUID: IMDFProject] = [:]

    func fetchAll() async throws -> [IMDFProject] {
        Array(projects.values)
    }

    func fetch(id: UUID) async throws -> IMDFProject? {
        projects[id]
    }

    func save(_ project: IMDFProject) async throws {
        projects[project.id] = project
    }

    func delete(id: UUID) async throws {
        projects[id] = nil
    }
}
