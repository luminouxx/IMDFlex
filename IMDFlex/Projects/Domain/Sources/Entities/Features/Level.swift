//
//  Level.swift
//  Domain
//

import Foundation

/// IMDF Level - Floor within a building
public struct Level: Identifiable, Codable, Sendable, Equatable {
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
        public var category: LevelCategory
        public var restriction: Restriction?
        public var ordinal: Int
        public var outdoor: Bool
        public var name: Label
        public var shortName: Label?
        public var displayPoint: DisplayPoint?
        public var addressId: UUID?
        public var buildingIds: [UUID]?
        
        enum CodingKeys: String, CodingKey {
            case category
            case restriction
            case ordinal
            case outdoor
            case name
            case shortName = "short_name"
            case displayPoint = "display_point"
            case addressId = "address_id"
            case buildingIds = "building_ids"
        }
        
        public init(
            category: LevelCategory = .unspecified,
            restriction: Restriction? = nil,
            ordinal: Int,
            outdoor: Bool = false,
            name: Label,
            shortName: Label? = nil,
            displayPoint: DisplayPoint? = nil,
            addressId: UUID? = nil,
            buildingIds: [UUID]? = nil
        ) {
            self.category = category
            self.restriction = restriction
            self.ordinal = ordinal
            self.outdoor = outdoor
            self.name = name
            self.shortName = shortName
            self.displayPoint = displayPoint
            self.addressId = addressId
            self.buildingIds = buildingIds
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
        try container.encode(FeatureType.level, forKey: .featureType)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(properties, forKey: .properties)
    }
}
