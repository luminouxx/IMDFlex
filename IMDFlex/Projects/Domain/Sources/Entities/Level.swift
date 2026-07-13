import Foundation

/// IMDF Level - 층
public struct Level: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String
    public var category: LevelCategory
    public var ordinal: Int
    public var shortName: String?
    public var coordinates: [Coordinate]
    public var units: [Unit]
    public var openings: [Opening]
    public var details: [Detail]
    public var fixtures: [Fixture]
    public var geofences: [Geofence]
    public var kiosks: [Kiosk]
    public var sections: [Section]
    
    public init(
        id: UUID = UUID(),
        name: String,
        category: LevelCategory = .unspecified,
        ordinal: Int,
        shortName: String? = nil,
        coordinates: [Coordinate] = [],
        units: [Unit] = [],
        openings: [Opening] = [],
        details: [Detail] = [],
        fixtures: [Fixture] = [],
        geofences: [Geofence] = [],
        kiosks: [Kiosk] = [],
        sections: [Section] = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.ordinal = ordinal
        self.shortName = shortName
        self.coordinates = coordinates
        self.units = units
        self.openings = openings
        self.details = details
        self.fixtures = fixtures
        self.geofences = geofences
        self.kiosks = kiosks
        self.sections = sections
    }
}

public enum LevelCategory: String, Codable, CaseIterable, Sendable {
    case arrivals
    case domesticArrivals = "arrivals.domestic"
    case internationalArrivals = "arrivals.intl"
    case departures
    case domesticDepartures = "departures.domestic"
    case internationalDepartures = "departures.intl"
    case parking
    case transit
    case unspecified
}
