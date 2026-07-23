import Foundation

/// Apple IMDF category collection names from `categories_20210728.csv`.
public enum IMDFCategoryFeature: String, Codable, CaseIterable, Sendable {
    case accessControl = "access-control"
    case accessibility
    case amenity
    case building
    case door
    case doorMaterial = "door-material"
    case fixture
    case footprint
    case geofence
    case level
    case occupant
    case opening
    case relationship
    case restriction
    case section
    case unit
    case venue
}

public struct IMDFCategoryEntry: Identifiable, Codable, Equatable, Sendable {
    public var feature: IMDFCategoryFeature
    public var value: String
    public var definition: String?

    public var id: String {
        [feature.rawValue, value].joined(separator: ":")
    }

    public init(
        feature: IMDFCategoryFeature,
        value: String,
        definition: String? = nil
    ) {
        self.feature = feature
        self.value = value
        self.definition = definition
    }
}

public struct IMDFCategoryFeatureSummary: Codable, Equatable, Sendable {
    public var feature: IMDFCategoryFeature
    public var categoryCount: Int
    public var representativeValues: [String]

    public init(
        feature: IMDFCategoryFeature,
        categoryCount: Int,
        representativeValues: [String]
    ) {
        self.feature = feature
        self.categoryCount = categoryCount
        self.representativeValues = representativeValues
    }
}

public struct IMDFCategoryCatalog: Codable, Equatable, Sendable {
    public var entries: [IMDFCategoryEntry]

    public init(entries: [IMDFCategoryEntry]) {
        self.entries = entries
    }

    public func entries(for feature: IMDFCategoryFeature) -> [IMDFCategoryEntry] {
        entries.filter { $0.feature == feature }
    }

    public func contains(_ value: String, for feature: IMDFCategoryFeature) -> Bool {
        entries.contains { $0.feature == feature && $0.value == value }
    }
}

public enum IMDFCategoryCatalogSource: Sendable {
    public static let appleCategories20210728FileName = "categories_20210728.csv"

    public static let appleCategories20210728FeatureSummaries: [IMDFCategoryFeatureSummary] = [
        .init(feature: .accessControl, categoryCount: 8, representativeValues: [
            "badgereader", "fingerprintreader", "guard", "keyaccess"
        ]),
        .init(feature: .accessibility, categoryCount: 10, representativeValues: [
            "assisted.listening", "braille", "hearing", "wheelchair"
        ]),
        .init(feature: .amenity, categoryCount: 172, representativeValues: [
            "atm", "drinkingfountain", "firstaid", "restroom.male"
        ]),
        .init(feature: .building, categoryCount: 5, representativeValues: [
            "parking", "transit", "transit.bus", "unspecified"
        ]),
        .init(feature: .door, categoryCount: 11, representativeValues: [
            "door", "open", "revolving", "turnstile"
        ]),
        .init(feature: .doorMaterial, categoryCount: 4, representativeValues: [
            "gate", "glass", "metal", "wood"
        ]),
        .init(feature: .fixture, categoryCount: 15, representativeValues: [
            "baggagecarousel", "checkin.desk", "furniture", "wall"
        ]),
        .init(feature: .footprint, categoryCount: 3, representativeValues: [
            "aerial", "ground", "subterranean"
        ]),
        .init(feature: .geofence, categoryCount: 8, representativeValues: [
            "concourse", "paidarea", "postsecurity", "terminal"
        ]),
        .init(feature: .level, categoryCount: 9, representativeValues: [
            "arrivals", "departures", "parking", "unspecified"
        ]),
        .init(feature: .occupant, categoryCount: 1116, representativeValues: [
            "3dprinting", "acai", "airportloungebar", "corporateoffices"
        ]),
        .init(feature: .opening, categoryCount: 7, representativeValues: [
            "automobile", "emergencyexit", "pedestrian.principal", "service"
        ]),
        .init(feature: .relationship, categoryCount: 7, representativeValues: [
            "elevator", "movingwalkway", "traversal", "traversal.path"
        ]),
        .init(feature: .restriction, categoryCount: 2, representativeValues: [
            "employeesonly", "restricted"
        ]),
        .init(feature: .section, categoryCount: 71, representativeValues: [
            "baggageclaim", "gatearea", "postsecurity", "walkway"
        ]),
        .init(feature: .unit, categoryCount: 63, representativeValues: [
            "foodservice", "restroom.male", "structure", "walkway"
        ]),
        .init(feature: .venue, categoryCount: 22, representativeValues: [
            "airport", "parkingfacility", "shoppingcenter", "university"
        ])
    ]
}
