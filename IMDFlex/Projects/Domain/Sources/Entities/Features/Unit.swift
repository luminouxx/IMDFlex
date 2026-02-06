//
//  Unit.swift
//  Domain
//

import Foundation

/// IMDF Unit - Spaces like rooms, corridors, etc.
public struct Unit: Identifiable, Codable, Sendable, Equatable {
    public var id: UUID
    public var geometry: Geometry
    public var properties: Properties
    
    public init(
        id: UUID = UUID(),
        geometry: Geometry,
        properties: Properties
    ) {
        self.id = id
        self.geometry = geometry
        self.properties = properties
    }
    
    // MARK: - Properties
    
    public struct Properties: Codable, Sendable, Equatable {
        public var category: UnitCategory
        public var restriction: Restriction?
        public var accessibility: [Accessibility]?
        public var name: Label?
        public var altName: Label?
        public var displayPoint: DisplayPoint?
        public var levelId: UUID
        
        enum CodingKeys: String, CodingKey {
            case category
            case restriction
            case accessibility
            case name
            case altName = "alt_name"
            case displayPoint = "display_point"
            case levelId = "level_id"
        }
        
        public init(
            category: UnitCategory,
            restriction: Restriction? = nil,
            accessibility: [Accessibility]? = nil,
            name: Label? = nil,
            altName: Label? = nil,
            displayPoint: DisplayPoint? = nil,
            levelId: UUID
        ) {
            self.category = category
            self.restriction = restriction
            self.accessibility = accessibility
            self.name = name
            self.altName = altName
            self.displayPoint = displayPoint
            self.levelId = levelId
        }
    }
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case featureType = "feature_type"
        case geometry
        case properties
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        geometry = try container.decode(Geometry.self, forKey: .geometry)
        properties = try container.decode(Properties.self, forKey: .properties)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode("Feature", forKey: .type)
        try container.encode(FeatureType.unit, forKey: .featureType)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(properties, forKey: .properties)
    }
}

// MARK: - Accessibility

/// Accessibility features
public enum Accessibility: Sendable, Equatable, Hashable {
    case hearingAccessible
    case visionAccessible
    case wheelchairAccessible
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .hearingAccessible: return "hearingaccessible"
        case .visionAccessible: return "visionaccessible"
        case .wheelchairAccessible: return "wheelchairaccessible"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "hearingaccessible": self = .hearingAccessible
        case "visionaccessible": self = .visionAccessible
        case "wheelchairaccessible": self = .wheelchairAccessible
        default: self = .unknown(rawValue)
        }
    }
}

extension Accessibility: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
