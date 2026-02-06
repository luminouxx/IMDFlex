//
//  FeatureType.swift
//  Domain
//

import Foundation

/// IMDF Feature Types
public enum FeatureType: String, Codable, Sendable {
    case address
    case amenity
    case anchor
    case building
    case detail
    case fixture
    case footprint
    case geofence
    case kiosk
    case level
    case occupant
    case opening
    case relationship
    case section
    case unit
    case venue
}
