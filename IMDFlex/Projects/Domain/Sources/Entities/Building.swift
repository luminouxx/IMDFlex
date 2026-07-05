import Foundation

/// IMDF Building - 건물
public struct Building: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String?
    public var category: BuildingCategory
    public var levels: [Level]
    public var footprint: Footprint?
    
    public init(
        id: UUID = UUID(),
        name: String? = nil,
        category: BuildingCategory = .unspecified,
        levels: [Level] = [],
        footprint: Footprint? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.levels = levels
        self.footprint = footprint
    }
}

public enum BuildingCategory: String, Codable, CaseIterable, Sendable {
    case parking
    case transit
    case transitBus = "transit.bus"
    case transitTrain = "transit.train"
    case unspecified
}

/// IMDF Footprint - 건물 외곽선
public struct Footprint: Identifiable, Codable, Sendable {
    public let id: UUID
    public var category: FootprintCategory
    public var coordinates: [Coordinate]
    
    public init(
        id: UUID = UUID(),
        category: FootprintCategory = .ground,
        coordinates: [Coordinate] = []
    ) {
        self.id = id
        self.category = category
        self.coordinates = coordinates
    }
}

public enum FootprintCategory: String, Codable, CaseIterable, Sendable {
    case aerial
    case ground
    case subterranean
}
