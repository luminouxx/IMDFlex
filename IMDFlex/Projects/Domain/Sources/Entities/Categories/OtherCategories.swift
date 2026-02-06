//
//  OtherCategories.swift
//  Domain
//

import Foundation

// MARK: - Occupant Category

/// IMDF Occupant categories
public enum OccupantCategory: Sendable, Equatable, Hashable {
    case airline
    case atm
    case bank
    case cafe
    case carRental
    case currencyExchange
    case entertainment
    case exhibit
    case foodService
    case government
    case healthServices
    case hotel
    case information
    case lounge
    case meetingRoom
    case parking
    case privateLounge
    case professional
    case retail
    case service
    case spa
    case transportation
    case unspecified
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .airline: return "airline"
        case .atm: return "atm"
        case .bank: return "bank"
        case .cafe: return "cafe"
        case .carRental: return "carrental"
        case .currencyExchange: return "currencyexchange"
        case .entertainment: return "entertainment"
        case .exhibit: return "exhibit"
        case .foodService: return "foodservice"
        case .government: return "government"
        case .healthServices: return "healthservices"
        case .hotel: return "hotel"
        case .information: return "information"
        case .lounge: return "lounge"
        case .meetingRoom: return "meetingroom"
        case .parking: return "parking"
        case .privateLounge: return "privatelounge"
        case .professional: return "professional"
        case .retail: return "retail"
        case .service: return "service"
        case .spa: return "spa"
        case .transportation: return "transportation"
        case .unspecified: return "unspecified"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "airline": self = .airline
        case "atm": self = .atm
        case "bank": self = .bank
        case "cafe": self = .cafe
        case "carrental": self = .carRental
        case "currencyexchange": self = .currencyExchange
        case "entertainment": self = .entertainment
        case "exhibit": self = .exhibit
        case "foodservice": self = .foodService
        case "government": self = .government
        case "healthservices": self = .healthServices
        case "hotel": self = .hotel
        case "information": self = .information
        case "lounge": self = .lounge
        case "meetingroom": self = .meetingRoom
        case "parking": self = .parking
        case "privatelounge": self = .privateLounge
        case "professional": self = .professional
        case "retail": self = .retail
        case "service": self = .service
        case "spa": self = .spa
        case "transportation": self = .transportation
        case "unspecified": self = .unspecified
        default: self = .unknown(rawValue)
        }
    }
}

extension OccupantCategory: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

// MARK: - Footprint Category

/// IMDF Footprint categories
public enum FootprintCategory: Sendable, Equatable, Hashable {
    case ground
    case aerial
    case subterranean
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .ground: return "ground"
        case .aerial: return "aerial"
        case .subterranean: return "subterranean"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "ground": self = .ground
        case "aerial": self = .aerial
        case "subterranean": self = .subterranean
        default: self = .unknown(rawValue)
        }
    }
}

extension FootprintCategory: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

// MARK: - Building Category

/// IMDF Building categories
public enum BuildingCategory: Sendable, Equatable, Hashable {
    case parking
    case unspecified
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .parking: return "parking"
        case .unspecified: return "unspecified"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "parking": self = .parking
        case "unspecified": self = .unspecified
        default: self = .unknown(rawValue)
        }
    }
}

extension BuildingCategory: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

// MARK: - Level Category

/// IMDF Level categories
public enum LevelCategory: Sendable, Equatable, Hashable {
    case arrivals
    case departures
    case parking
    case unspecified
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .arrivals: return "arrivals"
        case .departures: return "departures"
        case .parking: return "parking"
        case .unspecified: return "unspecified"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "arrivals": self = .arrivals
        case "departures": self = .departures
        case "parking": self = .parking
        case "unspecified": self = .unspecified
        default: self = .unknown(rawValue)
        }
    }
}

extension LevelCategory: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

// MARK: - Restriction

/// Access restriction types
public enum Restriction: Sendable, Equatable, Hashable {
    case employeesOnly
    case restricted
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .employeesOnly: return "employeesonly"
        case .restricted: return "restricted"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "employeesonly": self = .employeesOnly
        case "restricted": self = .restricted
        default: self = .unknown(rawValue)
        }
    }
}

extension Restriction: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
