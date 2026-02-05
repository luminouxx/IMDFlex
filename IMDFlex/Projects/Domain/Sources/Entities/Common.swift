import Foundation

/// IMDF Address - 주소
public struct Address: Identifiable, Codable, Sendable {
    public let id: UUID
    public var address: String?
    public var locality: String?
    public var province: String?
    public var country: String?
    public var postalCode: String?
    
    public init(
        id: UUID = UUID(),
        address: String? = nil,
        locality: String? = nil,
        province: String? = nil,
        country: String? = nil,
        postalCode: String? = nil
    ) {
        self.id = id
        self.address = address
        self.locality = locality
        self.province = province
        self.country = country
        self.postalCode = postalCode
    }
}

/// GeoJSON 좌표
public struct Coordinate: Codable, Sendable, Equatable {
    public var latitude: Double
    public var longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
