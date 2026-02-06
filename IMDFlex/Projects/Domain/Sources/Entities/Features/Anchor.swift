//
//  Anchor.swift
//  Domain
//

import Foundation

/// IMDF Anchor - Reference points for occupants/amenities
public struct Anchor: Identifiable, Codable, Sendable, Equatable {
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
        public var unitId: UUID
        public var addressId: UUID?
        
        enum CodingKeys: String, CodingKey {
            case unitId = "unit_id"
            case addressId = "address_id"
        }
        
        public init(
            unitId: UUID,
            addressId: UUID? = nil
        ) {
            self.unitId = unitId
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
        try container.encode(FeatureType.anchor, forKey: .featureType)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(properties, forKey: .properties)
    }
}
