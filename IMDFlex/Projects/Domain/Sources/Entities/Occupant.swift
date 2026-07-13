import Foundation

/// IMDF Occupant - 입주자
public struct Occupant: Identifiable, Codable, Sendable {
    public let id: UUID
    public var name: String
    public var category: OccupantCategory?
    public var anchorID: UUID?
    public var phone: String?
    public var website: URL?
    public var hours: String?
    
    public init(
        id: UUID = UUID(),
        name: String,
        category: OccupantCategory? = nil,
        anchorID: UUID? = nil,
        phone: String? = nil,
        website: URL? = nil,
        hours: String? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.anchorID = anchorID
        self.phone = phone
        self.website = website
        self.hours = hours
    }
}

public enum OccupantCategory: String, Codable, CaseIterable, Sendable {
    case retail = "shopping"
    case restaurant
    case cafe
    case bank
    case office = "corporateoffices"
    case medical = "medicalcenter"
    case government = "publicservices.government"
    case education
    case entertainment = "arts.entertainment"
    case service = "localservices"
}
