//
//  Geometry.swift
//  Domain
//

import Foundation

// MARK: - Geometry

/// GeoJSON Geometry types for IMDF
public enum Geometry: Codable, Sendable, Equatable {
    case point(Point)
    case lineString(LineString)
    case polygon(Polygon)
    case multiPolygon(MultiPolygon)
    case null
    
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Handle null geometry
        if container.allKeys.isEmpty {
            self = .null
            return
        }
        
        // Check if it's a null single value
        if let singleContainer = try? decoder.singleValueContainer(),
           singleContainer.decodeNil() {
            self = .null
            return
        }
        
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "Point":
            let coordinates = try container.decode([Double].self, forKey: .coordinates)
            guard let coord = Coordinate(array: coordinates) else {
                throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Point coordinates"))
            }
            self = .point(Point(coordinate: coord))
            
        case "LineString":
            let coordinates = try container.decode([[Double]].self, forKey: .coordinates)
            let coords = coordinates.compactMap { Coordinate(array: $0) }
            self = .lineString(LineString(coordinates: coords))
            
        case "Polygon":
            let coordinates = try container.decode([[[Double]]].self, forKey: .coordinates)
            let rings = coordinates.map { ring in
                ring.compactMap { Coordinate(array: $0) }
            }
            self = .polygon(Polygon(rings: rings))
            
        case "MultiPolygon":
            let coordinates = try container.decode([[[[Double]]]].self, forKey: .coordinates)
            let polygons = coordinates.map { polygonCoords in
                Polygon(rings: polygonCoords.map { ring in
                    ring.compactMap { Coordinate(array: $0) }
                })
            }
            self = .multiPolygon(MultiPolygon(polygons: polygons))
            
        default:
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Unknown geometry type: \(type)"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .point(let point):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode("Point", forKey: .type)
            try container.encode(point.coordinate.asArray, forKey: .coordinates)
            
        case .lineString(let lineString):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode("LineString", forKey: .type)
            try container.encode(lineString.coordinates.map(\.asArray), forKey: .coordinates)
            
        case .polygon(let polygon):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode("Polygon", forKey: .type)
            try container.encode(polygon.rings.map { $0.map(\.asArray) }, forKey: .coordinates)
            
        case .multiPolygon(let multiPolygon):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode("MultiPolygon", forKey: .type)
            try container.encode(
                multiPolygon.polygons.map { polygon in
                    polygon.rings.map { $0.map(\.asArray) }
                },
                forKey: .coordinates
            )
            
        case .null:
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
}

// MARK: - Point

public struct Point: Codable, Sendable, Equatable {
    public var coordinate: Coordinate
    
    public init(coordinate: Coordinate) {
        self.coordinate = coordinate
    }
    
    public init(longitude: Double, latitude: Double) {
        self.coordinate = Coordinate(longitude: longitude, latitude: latitude)
    }
}

// MARK: - LineString

public struct LineString: Codable, Sendable, Equatable {
    public var coordinates: [Coordinate]
    
    public init(coordinates: [Coordinate]) {
        self.coordinates = coordinates
    }
    
    public init(start: Coordinate, end: Coordinate) {
        self.coordinates = [start, end]
    }
}

// MARK: - Polygon

public struct Polygon: Codable, Sendable, Equatable {
    /// Outer ring is first, holes follow
    public var rings: [[Coordinate]]
    
    public init(rings: [[Coordinate]]) {
        self.rings = rings
    }
    
    public init(exteriorRing: [Coordinate]) {
        self.rings = [exteriorRing]
    }
    
    /// The exterior ring (outer boundary)
    public var exteriorRing: [Coordinate] {
        rings.first ?? []
    }
    
    /// Interior rings (holes)
    public var interiorRings: [[Coordinate]] {
        Array(rings.dropFirst())
    }
}

// MARK: - MultiPolygon

public struct MultiPolygon: Codable, Sendable, Equatable {
    public var polygons: [Polygon]
    
    public init(polygons: [Polygon]) {
        self.polygons = polygons
    }
}

// MARK: - DisplayPoint

/// A curated Point for label placement
public typealias DisplayPoint = Point
