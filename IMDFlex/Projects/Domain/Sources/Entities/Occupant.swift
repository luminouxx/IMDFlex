import Foundation

/// IMDF Occupant - 입주자
public struct Occupant: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String
    public var category: OccupantCategory?
    public var phone: String?
    public var website: URL?
    public var hours: String?
    
    public init(
        id: UUID = UUID(),
        name: String,
        category: OccupantCategory? = nil,
        phone: String? = nil,
        website: URL? = nil,
        hours: String? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.phone = phone
        self.website = website
        self.hours = hours
    }
}

public enum OccupantCategory: String, Codable, CaseIterable, Sendable {
    case retail
    case restaurant
    case cafe
    case bank
    case office
    case medical
    case government
    case education
    case entertainment
    case service
    case other
}
