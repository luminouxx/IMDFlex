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
    case automobile
    case bicycle
    case emergencyExit = "emergencyexit"
    case pedestrian
    case principalPedestrian = "pedestrian.principal"
    case transitPedestrian = "pedestrian.transit"
    case service
}

public enum AccessControl: String, Codable, CaseIterable, Sendable {
    case badgeReader = "badgereader"
    case fingerprintReader = "fingerprintreader"
    case guarded = "guard"
    case keyAccess = "keyaccess"
    case outOfService = "outofservice"
    case passwordAccess = "passwordaccess"
    case retinaScanner = "retinascanner"
    case voiceRecognition = "voicerecognition"
}
