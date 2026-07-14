import Foundation

/// IMDF Detail - level에 속한 선형 세부 요소
public struct Detail: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String?
    public var coordinates: [Coordinate]

    public init(
        id: UUID = UUID(),
        name: String? = nil,
        coordinates: [Coordinate] = []
    ) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
    }
}
