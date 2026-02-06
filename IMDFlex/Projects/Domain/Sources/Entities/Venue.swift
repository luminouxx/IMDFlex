import Foundation

/// IMDF Venue - 실내 지도의 최상위 컨테이너
public struct Venue: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String
    public var category: VenueCategory
    public var buildings: [Building]
    public var address: Address?
    
    public init(
        id: UUID = UUID(),
        name: String,
        category: VenueCategory,
        buildings: [Building] = [],
        address: Address? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.buildings = buildings
        self.address = address
    }
}

public enum VenueCategory: String, Codable, CaseIterable, Sendable {
    case airport
    case shoppingCenter = "shopping_center"
    case conventionCenter = "convention_center"
    case hospital
    case museum
    case parkingFacility = "parking_facility"
    case railStation = "rail_station"
    case stadium
    case university
    case other
}
