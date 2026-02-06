import Foundation
import Domain

/// 파일 기반 프로젝트 저장소
public final class ProjectRepository: ProjectRepositoryProtocol, @unchecked Sendable {
    private let fileManager = FileManager.default
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var projectsDirectory: URL {
        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent("Projects", isDirectory: true)
    }
    
    public init() {
        try? fileManager.createDirectory(at: projectsDirectory, withIntermediateDirectories: true)
    }
    
    public func fetchAll() async throws -> [IMDFProject] {
        let files = try fileManager.contentsOfDirectory(at: projectsDirectory, includingPropertiesForKeys: nil)
        return try files
            .filter { $0.pathExtension == "json" }
            .compactMap { url -> IMDFProject? in
                let data = try Data(contentsOf: url)
                return try? decoder.decode(IMDFProject.self, from: data)
            }
            .sorted { $0.updatedAt > $1.updatedAt }
    }
    
    public func fetch(id: UUID) async throws -> IMDFProject? {
        let url = projectsDirectory.appendingPathComponent("\(id.uuidString).json")
        guard fileManager.fileExists(atPath: url.path) else { return nil }
        let data = try Data(contentsOf: url)
        return try decoder.decode(IMDFProject.self, from: data)
    }
    
    public func save(_ project: IMDFProject) async throws {
        let url = projectsDirectory.appendingPathComponent("\(project.id.uuidString).json")
        let data = try encoder.encode(project)
        try data.write(to: url)
    }
    
    public func delete(id: UUID) async throws {
        let url = projectsDirectory.appendingPathComponent("\(id.uuidString).json")
        try fileManager.removeItem(at: url)
    }
}
