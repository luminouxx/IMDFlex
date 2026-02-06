import Foundation

/// 프로젝트 관리 UseCase
public final class ProjectUseCase: Sendable {
    private let repository: ProjectRepositoryProtocol
    
    public init(repository: ProjectRepositoryProtocol) {
        self.repository = repository
    }
    
    public func createProject(name: String) async throws -> IMDFProject {
        let project = IMDFProject(name: name)
        try await repository.save(project)
        return project
    }
    
    public func loadProjects() async throws -> [IMDFProject] {
        try await repository.fetchAll()
    }
    
    public func updateProject(_ project: IMDFProject) async throws {
        var updated = project
        updated = IMDFProject(
            id: project.id,
            name: project.name,
            venue: project.venue,
            createdAt: project.createdAt,
            updatedAt: Date()
        )
        try await repository.save(updated)
    }
    
    public func deleteProject(id: UUID) async throws {
        try await repository.delete(id: id)
    }
}
