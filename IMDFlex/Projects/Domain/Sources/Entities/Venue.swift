import Foundation

/// IMDF Venue - 실내 지도의 최상위 컨테이너
public struct Venue: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String
    public var category: VenueCategory
    public var coordinates: [Coordinate]
    public var buildings: [Building]
    public var address: Address?
    
    public init(
        id: UUID = UUID(),
        name: String,
        category: VenueCategory,
        coordinates: [Coordinate] = [],
        buildings: [Building] = [],
        address: Address? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.coordinates = coordinates
        self.buildings = buildings
        self.address = address
    }
}

public enum VenueCategory: String, Codable, CaseIterable, Sendable {
    case airport
    case internationalAirport = "airport.intl"
    case aquarium
    case businessCampus = "businesscampus"
    case casino
    case communityCenter = "communitycenter"
    case conventionCenter = "conventioncenter"
    case governmentFacility = "governmentfacility"
    case healthcareFacility = "healthcarefacility"
    case hotel
    case museum
    case parkingFacility = "parkingfacility"
    case resort
    case retailStore = "retailstore"
    case shoppingCenter = "shoppingcenter"
    case stadium
    case stripMall = "stripmall"
    case theater
    case themePark = "themepark"
    case trainStation = "trainstation"
    case transitStation = "transitstation"
    case university
}
