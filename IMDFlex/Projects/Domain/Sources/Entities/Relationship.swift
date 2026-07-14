import Foundation

/// IMDF Relationship - 이동/연결 관계
public struct Relationship: Identifiable, Codable, Sendable {
    public let id: UUID
    public var category: RelationshipCategory
    public var direction: RelationshipDirection?
    public var originID: UUID
    public var destinationID: UUID

    public init(
        id: UUID = UUID(),
        category: RelationshipCategory,
        direction: RelationshipDirection? = nil,
        originID: UUID,
        destinationID: UUID
    ) {
        self.id = id
        self.category = category
        self.direction = direction
        self.originID = originID
        self.destinationID = destinationID
    }
}

public enum RelationshipCategory: String, Codable, CaseIterable, Sendable {
    case elevator
    case escalator
    case movingWalkway = "movingwalkway"
    case ramp
    case stairs
    case traversal
    case traversalPath = "traversal.path"
}

public enum RelationshipDirection: String, Codable, CaseIterable, Sendable {
    case bidirectional
    case unidirectional
}
