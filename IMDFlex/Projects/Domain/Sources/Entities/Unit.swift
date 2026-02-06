import Foundation

/// IMDF Unit - 공간 (방, 복도 등)
public struct Unit: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String?
    public var category: UnitCategory
    public var coordinates: [Coordinate]
    public var amenities: [Amenity]
    public var occupants: [Occupant]
    
    public init(
        id: UUID = UUID(),
        name: String? = nil,
        category: UnitCategory,
        coordinates: [Coordinate] = [],
        amenities: [Amenity] = [],
        occupants: [Occupant] = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.coordinates = coordinates
        self.amenities = amenities
        self.occupants = occupants
    }
}

public enum UnitCategory: String, Codable, CaseIterable, Sendable {
    case room
    case corridor
    case lobby
    case restroom
    case stairs
    case elevator
    case escalator
    case parking
    case office
    case retail
    case foodService = "food_service"
    case storage
    case mechanical
    case other
}
