import Foundation
import XCTest
@testable import Domain

final class ProjectUseCaseTests: XCTestCase {
    func testCreateProjectSavesProjectThroughRepositoryProtocol() async throws {
        let repository = InMemoryProjectRepository()
        let useCase = ProjectUseCase(repository: repository)

        let project = try await useCase.createProject(name: "Indoor Mapping")
        let savedProject = try await repository.fetch(id: project.id)

        XCTAssertEqual(savedProject?.id, project.id)
        XCTAssertEqual(savedProject?.name, "Indoor Mapping")
        XCTAssertNil(savedProject?.venue)
    }

    func testLoadProjectsReturnsRepositoryProjects() async throws {
        let repository = InMemoryProjectRepository()
        let useCase = ProjectUseCase(repository: repository)
        let firstProject = IMDFProject(name: "First Project")
        let secondProject = IMDFProject(name: "Second Project")

        try await repository.save(firstProject)
        try await repository.save(secondProject)

        let projects = try await useCase.loadProjects()
        let projectIDs = Set(projects.map(\.id))

        XCTAssertEqual(projectIDs, [firstProject.id, secondProject.id])
    }

    func testUpdateProjectRefreshesUpdatedAtAndPreservesProjectContent() async throws {
        let repository = InMemoryProjectRepository()
        let useCase = ProjectUseCase(repository: repository)
        let createdAt = Date(timeIntervalSince1970: 100)
        let oldUpdatedAt = Date(timeIntervalSince1970: 200)
        let venue = Venue(name: "Venue", category: .university)
        let project = IMDFProject(
            name: "Project",
            venue: venue,
            createdAt: createdAt,
            updatedAt: oldUpdatedAt
        )

        try await useCase.updateProject(project)

        let fetchedProject = try await repository.fetch(id: project.id)
        let updatedProject = try XCTUnwrap(fetchedProject)
        XCTAssertEqual(updatedProject.id, project.id)
        XCTAssertEqual(updatedProject.name, project.name)
        XCTAssertEqual(updatedProject.venue?.id, venue.id)
        XCTAssertEqual(updatedProject.createdAt, createdAt)
        XCTAssertGreaterThan(updatedProject.updatedAt, oldUpdatedAt)
    }

    func testDeleteProjectRemovesProjectThroughRepositoryProtocol() async throws {
        let repository = InMemoryProjectRepository()
        let useCase = ProjectUseCase(repository: repository)
        let project = IMDFProject(name: "Project To Delete")

        try await repository.save(project)
        try await useCase.deleteProject(id: project.id)

        let deletedProject = try await repository.fetch(id: project.id)
        XCTAssertNil(deletedProject)
    }
}

private actor InMemoryProjectRepository: ProjectRepositoryProtocol {
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
