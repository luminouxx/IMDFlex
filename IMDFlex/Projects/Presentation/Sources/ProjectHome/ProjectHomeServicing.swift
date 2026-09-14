import Foundation
import Domain

/// Project Home's dependency boundary. The concrete Domain use case conforms
/// without exposing persistence details to Presentation.
public protocol ProjectHomeServicing: Sendable {
    func loadProjects() async throws -> [IMDFProject]
    func createProject(name: String) async throws -> IMDFProject
    func deleteProject(id: UUID) async throws
}

extension ProjectUseCase: ProjectHomeServicing {}
