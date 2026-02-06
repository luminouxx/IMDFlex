//
//  Address.swift
//  Domain
//

import Foundation

/// IMDF Address - Postal address information
public struct Address: Identifiable, Codable, Sendable, Equatable {
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
        public var address: String
        public var unit: String?
        public var locality: String
        public var province: String?
        public var country: String
        public var postalCode: String?
        public var postalCodeExt: String?
        public var postalCodeVanity: String?
        
        enum CodingKeys: String, CodingKey {
            case address
            case unit
            case locality
            case province
            case country
            case postalCode = "postal_code"
            case postalCodeExt = "postal_code_ext"
            case postalCodeVanity = "postal_code_vanity"
        }
        
        public init(
            address: String,
            unit: String? = nil,
            locality: String,
            province: String? = nil,
            country: String,
            postalCode: String? = nil,
            postalCodeExt: String? = nil,
            postalCodeVanity: String? = nil
        ) {
            self.address = address
            self.unit = unit
            self.locality = locality
            self.province = province
            self.country = country
            self.postalCode = postalCode
            self.postalCodeExt = postalCodeExt
            self.postalCodeVanity = postalCodeVanity
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
        try container.encode(FeatureType.address, forKey: .featureType)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(properties, forKey: .properties)
    }
}
