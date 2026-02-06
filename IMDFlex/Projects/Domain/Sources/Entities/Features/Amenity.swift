//
//  Amenity.swift
//  Domain
//

import Foundation

/// IMDF Amenity - Points of interest (ATM, restroom, etc.)
public struct Amenity: Identifiable, Codable, Sendable, Equatable {
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
        public var category: AmenityCategory
        public var accessibility: [Accessibility]?
        public var name: Label?
        public var altName: Label?
        public var hours: String?
        public var phone: String?
        public var website: URL?
        public var unitIds: [UUID]
        public var addressId: UUID?
        public var correlationId: UUID?
        
        enum CodingKeys: String, CodingKey {
            case category
            case accessibility
            case name
            case altName = "alt_name"
            case hours
            case phone
            case website
            case unitIds = "unit_ids"
            case addressId = "address_id"
            case correlationId = "correlation_id"
        }
        
        public init(
            category: AmenityCategory,
            accessibility: [Accessibility]? = nil,
            name: Label? = nil,
            altName: Label? = nil,
            hours: String? = nil,
            phone: String? = nil,
            website: URL? = nil,
            unitIds: [UUID],
            addressId: UUID? = nil,
            correlationId: UUID? = nil
        ) {
            self.category = category
            self.accessibility = accessibility
            self.name = name
            self.altName = altName
            self.hours = hours
            self.phone = phone
            self.website = website
            self.unitIds = unitIds
            self.addressId = addressId
            self.correlationId = correlationId
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
        try container.encode(FeatureType.amenity, forKey: .featureType)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(properties, forKey: .properties)
    }
}
