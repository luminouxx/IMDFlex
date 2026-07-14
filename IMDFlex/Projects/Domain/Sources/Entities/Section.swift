import Foundation

/// IMDF Section - level 안의 의미 있는 구역
public struct Section: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String?
    public var category: SectionCategory
    public var coordinates: [Coordinate]

    public init(
        id: UUID = UUID(),
        name: String? = nil,
        category: SectionCategory = .walkway,
        coordinates: [Coordinate] = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.coordinates = coordinates
    }
}

public enum SectionCategory: String, Codable, CaseIterable, Sendable {
    case arcade
    case baggageClaim = "baggageclaim"
    case checkIn = "checkin"
    case concessions
    case eatingDrinking = "eatingdrinking"
    case entertainmentArea = "entertainmentarea"
    case exhibit
    case gateArea = "gatearea"
    case information
    case paidArea = "paidarea"
    case parking
    case platform
    case postSecurity = "postsecurity"
    case preSecurity = "presecurity"
    case privateArea = "private"
    case recreation
    case retail
    case road
    case seating
    case security
    case serviceArea = "servicearea"
    case ticketing
    case vegetation
    case walkway
}
