import Foundation

/// IMDF Fixture - level에 배치되는 고정 구조물 또는 가구
public struct Fixture: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String?
    public var category: FixtureCategory
    public var coordinates: [Coordinate]
    public var anchorIDs: [UUID]

    public init(
        id: UUID = UUID(),
        name: String? = nil,
        category: FixtureCategory = .furniture,
        coordinates: [Coordinate] = [],
        anchorIDs: [UUID] = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.coordinates = coordinates
        self.anchorIDs = anchorIDs
    }
}

public enum FixtureCategory: String, Codable, CaseIterable, Sendable {
    case baggageCarousel = "baggagecarousel"
    case boardingGateDesk = "boardinggate.desk"
    case checkInDesk = "checkin.desk"
    case checkInKiosk = "checkin.kiosk"
    case desk
    case equipment
    case furniture
    case immigrationDesk = "immigration.desk"
    case inspectionDesk = "inspection.desk"
    case obstruction
    case securityEquipment = "securityequipment"
    case stage
    case vegetation
    case wall
    case water
}
