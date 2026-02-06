//
//  Coordinate.swift
//  Domain
//

import Foundation

/// GeoJSON coordinate (WGS84)
/// - Note: GeoJSON uses [longitude, latitude] order (x, y)
public struct Coordinate: Codable, Sendable, Equatable, Hashable {
    public var longitude: Double
    public var latitude: Double
    public var altitude: Double?
    
    public init(longitude: Double, latitude: Double, altitude: Double? = nil) {
        self.longitude = longitude
        self.latitude = latitude
        self.altitude = altitude
    }
    
    // MARK: - Codable (GeoJSON array format)
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        longitude = try container.decode(Double.self)
        latitude = try container.decode(Double.self)
        altitude = try? container.decode(Double.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(longitude)
        try container.encode(latitude)
        if let altitude {
            try container.encode(altitude)
        }
    }
}

// MARK: - Convenience

public extension Coordinate {
    /// Creates coordinate from [longitude, latitude] array
    init?(array: [Double]) {
        guard array.count >= 2 else { return nil }
        self.longitude = array[0]
        self.latitude = array[1]
        self.altitude = array.count > 2 ? array[2] : nil
    }
    
    /// Returns as [longitude, latitude] array
    var asArray: [Double] {
        if let altitude {
            return [longitude, latitude, altitude]
        }
        return [longitude, latitude]
    }
}
