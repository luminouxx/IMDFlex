//
//  Footprint.swift
//  Domain
//

import Foundation

/// IMDF Footprint - Building outline
public struct Footprint: Identifiable, Codable, Sendable, Equatable {
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
        public var category: FootprintCategory
        public var name: Label?
        public var buildingIds: [UUID]
        
        enum CodingKeys: String, CodingKey {
            case category
            case name
            case buildingIds = "building_ids"
        }
        
        public init(
            category: FootprintCategory = .ground,
            name: Label? = nil,
            buildingIds: [UUID]
        ) {
            self.category = category
            self.name = name
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
        try container.encode(FeatureType.footprint, forKey: .featureType)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(properties, forKey: .properties)
    }
}
