import Foundation

/// IMDF Opening - 출입구
public struct Opening: Identifiable, Codable, Sendable {
    public let id: UUID
    public var category: OpeningCategory
    public var coordinates: [Coordinate]
    public var accessControl: AccessControl?
    
    public init(
        id: UUID = UUID(),
        category: OpeningCategory,
        coordinates: [Coordinate] = [],
        accessControl: AccessControl? = nil
    ) {
        self.id = id
        self.category = category
        self.coordinates = coordinates
        self.accessControl = accessControl
    }
}

public enum OpeningCategory: String, Codable, CaseIterable, Sendable {
    case door
    case emergencyDoor = "emergency_door"
    case gate
    case entrance
    case exit
    case emergencyExit = "emergency_exit"
    case other
}

public enum AccessControl: String, Codable, CaseIterable, Sendable {
    case open
    case restricted
    case locked
    case keyCard = "key_card"
    case biometric
}
