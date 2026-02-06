//
//  Opening.swift
//  Domain
//

import Foundation

/// IMDF Opening - Doors, entrances, exits
public struct Opening: Identifiable, Codable, Sendable, Equatable {
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
        public var category: OpeningCategory
        public var accessibility: [Accessibility]?
        public var accessControl: AccessControl?
        public var door: DoorInfo?
        public var name: Label?
        public var altName: Label?
        public var displayPoint: DisplayPoint?
        public var levelId: UUID
        
        enum CodingKeys: String, CodingKey {
            case category
            case accessibility
            case accessControl = "access_control"
            case door
            case name
            case altName = "alt_name"
            case displayPoint = "display_point"
            case levelId = "level_id"
        }
        
        public init(
            category: OpeningCategory,
            accessibility: [Accessibility]? = nil,
            accessControl: AccessControl? = nil,
            door: DoorInfo? = nil,
            name: Label? = nil,
            altName: Label? = nil,
            displayPoint: DisplayPoint? = nil,
            levelId: UUID
        ) {
            self.category = category
            self.accessibility = accessibility
            self.accessControl = accessControl
            self.door = door
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
        try container.encode(FeatureType.opening, forKey: .featureType)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(properties, forKey: .properties)
    }
}

// MARK: - Access Control

/// Access control types for openings
public enum AccessControl: Sendable, Equatable, Hashable {
    case badgeReader
    case biometric
    case key
    case keypad
    case security
    case ticket
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .badgeReader: return "badgereader"
        case .biometric: return "biometric"
        case .key: return "key"
        case .keypad: return "keypad"
        case .security: return "security"
        case .ticket: return "ticket"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "badgereader": self = .badgeReader
        case "biometric": self = .biometric
        case "key": self = .key
        case "keypad": self = .keypad
        case "security": self = .security
        case "ticket": self = .ticket
        default: self = .unknown(rawValue)
        }
    }
}

extension AccessControl: Codable {
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
