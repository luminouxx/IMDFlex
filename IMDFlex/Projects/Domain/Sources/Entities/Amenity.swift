import Foundation

/// IMDF Amenity - 편의시설
public struct Amenity: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String?
    public var category: AmenityCategory
    public var coordinate: Coordinate?
    
    public init(
        id: UUID = UUID(),
        name: String? = nil,
        category: AmenityCategory,
        coordinate: Coordinate? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.coordinate = coordinate
    }
}

public enum AmenityCategory: String, Codable, CaseIterable, Sendable {
    case atm
    case elevator
    case escalator
    case stairs
    case restroom
    case restroomMale = "restroom_male"
    case restroomFemale = "restroom_female"
    case restroomUnisex = "restroom_unisex"
    case drinkingWater = "drinking_water"
    case information
    case ticketMachine = "ticket_machine"
    case parking
    case chargingStation = "charging_station"
    case firstAid = "first_aid"
    case other
}
