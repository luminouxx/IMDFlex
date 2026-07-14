import Foundation

/// IMDF Kiosk - level에 배치되는 키오스크 영역
public struct Kiosk: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String?
    public var coordinates: [Coordinate]
    public var anchorIDs: [UUID]

    public init(
        id: UUID = UUID(),
        name: String? = nil,
        coordinates: [Coordinate] = [],
        anchorIDs: [UUID] = []
    ) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.anchorIDs = anchorIDs
    }
}
