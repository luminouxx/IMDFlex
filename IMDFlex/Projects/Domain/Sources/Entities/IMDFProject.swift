import Foundation

/// 앱 내 프로젝트 관리 모델
public struct IMDFProject: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String
    public var venue: Venue?
    public var createdAt: Date
    public var updatedAt: Date
    
    public init(
        id: UUID = UUID(),
        name: String,
        venue: Venue? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.venue = venue
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
