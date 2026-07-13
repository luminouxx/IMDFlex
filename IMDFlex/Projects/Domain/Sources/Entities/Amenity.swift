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
    case restroomMale = "restroom.male"
    case restroomFemale = "restroom.female"
    case restroomUnisex = "restroom.unisex"
    case drinkingWater = "drinkingfountain"
    case information
    case ticketMachine = "ticketing"
    case parking
    case chargingStation = "powerchargingstation"
    case firstAid = "firstaid"
    case unspecified
}
