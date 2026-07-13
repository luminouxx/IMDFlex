import Foundation

/// IMDF Unit - 공간 (방, 복도 등)
public struct Unit: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String?
    public var category: UnitCategory
    public var coordinates: [Coordinate]
    public var anchors: [Anchor]
    public var amenities: [Amenity]
    public var occupants: [Occupant]
    
    public init(
        id: UUID = UUID(),
        name: String? = nil,
        category: UnitCategory,
        coordinates: [Coordinate] = [],
        anchors: [Anchor] = [],
        amenities: [Amenity] = [],
        occupants: [Occupant] = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.coordinates = coordinates
        self.anchors = anchors
        self.amenities = amenities
        self.occupants = occupants
    }
}

public enum UnitCategory: String, Codable, CaseIterable, Sendable {
    case room
    case walkway
    case lobby
    case restroom
    case stairs
    case elevator
    case escalator
    case parking
    case office
    case foodService = "foodservice"
    case storage
    case structure
    case unspecified
}
