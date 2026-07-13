import Foundation

/// IMDF Geofence - level 또는 building에 적용되는 제한/구역 경계
public struct Geofence: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String?
    public var category: GeofenceCategory
    public var coordinates: [Coordinate]

    public init(
        id: UUID = UUID(),
        name: String? = nil,
        category: GeofenceCategory = .geofence,
        coordinates: [Coordinate] = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.coordinates = coordinates
    }
}

public enum GeofenceCategory: String, Codable, CaseIterable, Sendable {
    case concourse
    case geofence
    case paidArea = "paidarea"
    case platform
    case postSecurity = "postsecurity"
    case preSecurity = "presecurity"
    case terminal
    case underConstruction = "underconstruction"
}
