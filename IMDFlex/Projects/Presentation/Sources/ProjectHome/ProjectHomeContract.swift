import Foundation
import Observation
import Domain

/// Project Home's dependency boundary. The concrete Domain use case conforms
/// without exposing persistence details to Presentation.
public protocol ProjectHomeServicing: Sendable {
    func loadProjects() async throws -> [IMDFProject]
    func createProject(name: String) async throws -> IMDFProject
    func deleteProject(id: UUID) async throws
}

extension ProjectUseCase: ProjectHomeServicing {}

public enum ProjectHomeLoadState: Equatable, Sendable {
    case idle
    case loading
    case loaded
    case failed
}

public enum ProjectHomeAlert: Equatable, Sendable {
    case invalidProjectName
    case loadingFailed
    case creationFailed
    case deletionFailed
}

public enum ProjectHomeRoute: Equatable, Sendable {
    case workspace(projectID: UUID)
}

/// Compile-time contract for the test-first review phase.
/// Product behavior is intentionally left unimplemented until the tests are approved.
@MainActor
@Observable
public final class ProjectHomeViewModel {
    public var searchQuery = ""
    public var newProjectName = ""

    public private(set) var projects: [IMDFProject] = []
    public private(set) var loadState: ProjectHomeLoadState = .idle
    public private(set) var alert: ProjectHomeAlert?
    public private(set) var route: ProjectHomeRoute?
    public private(set) var pendingDeletionID: UUID?
    public private(set) var isCreatingProject = false

    private let service: any ProjectHomeServicing

    public init(service: any ProjectHomeServicing) {
        self.service = service
    }

    public var filteredProjects: [IMDFProject] {
        projects
    }

    public var canCreateProject: Bool {
        false
    }

    public func loadIfNeeded() async {}

    public func retryLoading() async {}

    public func createProject() async {}

    public func openProject(projectID: UUID) {}

    public func requestDeletion(projectID: UUID) {}

    public func cancelDeletion() {}

    public func confirmDeletion() async {}
}
