import Foundation

/// IMDF Building - 건물
public struct Building: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String?
    public var levels: [Level]
    public var footprint: Footprint?
    
    public init(
        id: UUID = UUID(),
        name: String? = nil,
        levels: [Level] = [],
        footprint: Footprint? = nil
    ) {
        self.id = id
        self.name = name
        self.levels = levels
        self.footprint = footprint
    }
}

/// IMDF Footprint - 건물 외곽선
public struct Footprint: Identifiable, Codable, Sendable {
    public let id: UUID
    public var coordinates: [Coordinate]
    
    public init(id: UUID = UUID(), coordinates: [Coordinate] = []) {
        self.id = id
        self.coordinates = coordinates
    }
}
