import Foundation
import Domain
@testable import Presentation

actor ProjectHomeServiceSpy: ProjectHomeServicing {
    enum LoadResponse: Sendable {
        case success([IMDFProject])
        case failure
    }

    enum CreateResponse: Sendable {
        case success(IMDFProject)
        case failure
    }

    enum DeleteResponse: Sendable {
        case success
        case failure
    }

    private(set) var loadProjectsCallCount = 0
    private(set) var createProjectCallCount = 0
    private(set) var deleteProjectCallCount = 0
    private(set) var receivedProjectNames: [String] = []
    private(set) var receivedDeletionIDs: [UUID] = []

    private var loadResponses: [LoadResponse]
    private let createResponse: CreateResponse
    private let deleteResponse: DeleteResponse

    init(
        loadResponses: [LoadResponse],
        createResponse: CreateResponse,
        deleteResponse: DeleteResponse
    ) {
        self.loadResponses = loadResponses
        self.createResponse = createResponse
        self.deleteResponse = deleteResponse
    }

    func loadProjects() async throws -> [IMDFProject] {
        loadProjectsCallCount += 1
        let response = loadResponses.isEmpty ? .success([]) : loadResponses.removeFirst()

        switch response {
        case .success(let projects):
            return projects
        case .failure:
            throw ProjectHomeServiceError.requestFailed
        }
    }

    func createProject(name: String) async throws -> IMDFProject {
        createProjectCallCount += 1
        receivedProjectNames.append(name)

        switch createResponse {
        case .success(let project):
            return project
        case .failure:
            throw ProjectHomeServiceError.requestFailed
        }
    }

    func deleteProject(id: UUID) async throws {
        deleteProjectCallCount += 1
        receivedDeletionIDs.append(id)

        if case .failure = deleteResponse {
            throw ProjectHomeServiceError.requestFailed
        }
    }
}

actor SuspendingProjectHomeServiceSpy: ProjectHomeServicing {
    private(set) var createProjectCallCount = 0

    private let createdProject: IMDFProject
    private var creationContinuation: CheckedContinuation<IMDFProject, Never>?

    init(createdProject: IMDFProject) {
        self.createdProject = createdProject
    }

    func loadProjects() async throws -> [IMDFProject] {
        []
    }

    func createProject(name: String) async throws -> IMDFProject {
        createProjectCallCount += 1

        return await withCheckedContinuation { continuation in
            creationContinuation = continuation
        }
    }

    func deleteProject(id: UUID) async throws {}

    func completeCreation() {
        creationContinuation?.resume(returning: createdProject)
        creationContinuation = nil
    }
}

enum ProjectHomeServiceError: Error {
    case requestFailed
}
