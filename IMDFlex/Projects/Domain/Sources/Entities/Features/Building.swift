//
//  Building.swift
//  Domain
//

import Foundation

/// IMDF Building - Physical building structure
public struct Building: Identifiable, Codable, Sendable, Equatable {
    public var id: UUID
    public var geometry: Geometry
    public var properties: Properties
    
    public init(
        id: UUID = UUID(),
        geometry: Geometry = .null,
        properties: Properties
    ) {
        self.id = id
        self.geometry = geometry
        self.properties = properties
    }
    
    // MARK: - Properties
    
    public struct Properties: Codable, Sendable, Equatable {
        public var category: BuildingCategory
        public var restriction: Restriction?
        public var name: Label?
        public var altName: Label?
        public var displayPoint: DisplayPoint?
        public var addressId: UUID?
        
        enum CodingKeys: String, CodingKey {
            case category
            case restriction
            case name
            case altName = "alt_name"
            case displayPoint = "display_point"
            case addressId = "address_id"
        }
        
        public init(
            category: BuildingCategory = .unspecified,
            restriction: Restriction? = nil,
            name: Label? = nil,
            altName: Label? = nil,
            displayPoint: DisplayPoint? = nil,
            addressId: UUID? = nil
        ) {
            self.category = category
            self.restriction = restriction
            self.name = name
            self.altName = altName
            self.displayPoint = displayPoint
            self.addressId = addressId
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
        try container.encode(FeatureType.building, forKey: .featureType)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(properties, forKey: .properties)
    }
}
