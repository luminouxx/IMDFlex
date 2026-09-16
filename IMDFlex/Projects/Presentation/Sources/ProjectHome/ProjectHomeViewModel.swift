import Foundation
import Observation
import Domain

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

    @ObservationIgnored
    private let service: any ProjectHomeServicing

    public init(service: any ProjectHomeServicing) {
        self.service = service
    }

    public var filteredProjects: [IMDFProject] {
        guard isFilteringProjects else {
            return projects
        }

        return projects.filter { project in
            project.name.localizedStandardContains(normalizedSearchQuery)
        }
    }

    public var isFilteringProjects: Bool {
        !normalizedSearchQuery.isEmpty
    }

    public var canCreateProject: Bool {
        !normalizedProjectName.isEmpty && !isCreatingProject
    }

    public func loadIfNeeded() async {
        guard loadState == .idle else {
            return
        }

        await loadProjects()
    }

    public func retryLoading() async {
        guard loadState == .failed else {
            return
        }

        await loadProjects()
    }

    public func createProject() async {
        guard !normalizedProjectName.isEmpty else {
            alert = .invalidProjectName
            return
        }

        guard !isCreatingProject else {
            return
        }

        isCreatingProject = true
        alert = nil

        defer {
            isCreatingProject = false
        }

        do {
            let project = try await service.createProject(name: normalizedProjectName)
            projects.append(project)
            projects = sortedByRecentUpdate(projects)
            newProjectName = ""
            route = .workspace(projectID: project.id)
        } catch {
            alert = .creationFailed
        }
    }

    public func openProject(projectID: UUID) {
        route = .workspace(projectID: projectID)
    }

    public func requestDeletion(projectID: UUID) {
        guard projects.contains(where: { $0.id == projectID }) else {
            return
        }

        pendingDeletionID = projectID
    }

    public func cancelDeletion() {
        pendingDeletionID = nil
    }

    public func confirmDeletion() async {
        guard let pendingDeletionID else {
            return
        }

        alert = nil

        do {
            try await service.deleteProject(id: pendingDeletionID)
            projects.removeAll { $0.id == pendingDeletionID }
            self.pendingDeletionID = nil
        } catch {
            alert = .deletionFailed
        }
    }

    private var normalizedProjectName: String {
        newProjectName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var normalizedSearchQuery: String {
        searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func loadProjects() async {
        loadState = .loading
        alert = nil

        do {
            let loadedProjects = try await service.loadProjects()
            projects = sortedByRecentUpdate(loadedProjects)
            loadState = .loaded
        } catch {
            loadState = .failed
            alert = .loadingFailed
        }
    }

    private func sortedByRecentUpdate(_ projects: [IMDFProject]) -> [IMDFProject] {
        projects.sorted { first, second in
            first.updatedAt > second.updatedAt
        }
    }
}
