import Foundation

/// 프로젝트 저장소 프로토콜 (Data 레이어에서 구현)
public protocol ProjectRepositoryProtocol: Sendable {
    func fetchAll() async throws -> [IMDFProject]
    func fetch(id: UUID) async throws -> IMDFProject?
    func save(_ project: IMDFProject) async throws
    func delete(id: UUID) async throws
}

/// IMDF 내보내기 프로토콜
public protocol IMDFExporterProtocol: Sendable {
    func export(_ venue: Venue) async throws -> Data
}
