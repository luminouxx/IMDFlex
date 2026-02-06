//
//  Venue.swift
//  Domain
//

import Foundation

/// IMDF Venue - Top-level container for an indoor map
public struct Venue: Identifiable, Codable, Sendable, Equatable {
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
        public var category: VenueCategory
        public var restriction: Restriction?
        public var name: Label
        public var altName: Label?
        public var hours: String?
        public var phone: String?
        public var website: URL?
        public var displayPoint: DisplayPoint?
        public var addressId: UUID?
        
        enum CodingKeys: String, CodingKey {
            case category
            case restriction
            case name
            case altName = "alt_name"
            case hours
            case phone
            case website
            case displayPoint = "display_point"
            case addressId = "address_id"
        }
        
        public init(
            category: VenueCategory,
            restriction: Restriction? = nil,
            name: Label,
            altName: Label? = nil,
            hours: String? = nil,
            phone: String? = nil,
            website: URL? = nil,
            displayPoint: DisplayPoint? = nil,
            addressId: UUID? = nil
        ) {
            self.category = category
            self.restriction = restriction
            self.name = name
            self.altName = altName
            self.hours = hours
            self.phone = phone
            self.website = website
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
        try container.encode(FeatureType.venue, forKey: .featureType)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(properties, forKey: .properties)
    }
}
