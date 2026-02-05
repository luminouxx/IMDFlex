import Foundation

/// IMDF Level - 층
public struct Level: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String
    public var ordinal: Int
    public var shortName: String?
    public var units: [Unit]
    public var openings: [Opening]
    
    public init(
        id: UUID = UUID(),
        name: String,
        ordinal: Int,
        shortName: String? = nil,
        units: [Unit] = [],
        openings: [Opening] = []
    ) {
        self.id = id
        self.name = name
        self.ordinal = ordinal
        self.shortName = shortName
        self.units = units
        self.openings = openings
    }
}
