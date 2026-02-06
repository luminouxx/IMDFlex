//
//  VenueCategory.swift
//  Domain
//

import Foundation

/// IMDF Venue categories
public enum VenueCategory: Sendable, Equatable, Hashable {
    case airport
    case aquarium
    case businessCampus
    case casino
    case conventionCenter
    case governmentFacility
    case healthcareFacility
    case hotel
    case museum
    case parkingFacility
    case resort
    case retailStore
    case shoppingCenter
    case stadium
    case stripMall
    case theater
    case themePark
    case trainStation
    case transitStation
    case university
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .airport: return "airport"
        case .aquarium: return "aquarium"
        case .businessCampus: return "businesscampus"
        case .casino: return "casino"
        case .conventionCenter: return "conventioncenter"
        case .governmentFacility: return "governmentfacility"
        case .healthcareFacility: return "healthcarefacility"
        case .hotel: return "hotel"
        case .museum: return "museum"
        case .parkingFacility: return "parkingfacility"
        case .resort: return "resort"
        case .retailStore: return "retailstore"
        case .shoppingCenter: return "shoppingcenter"
        case .stadium: return "stadium"
        case .stripMall: return "stripmall"
        case .theater: return "theater"
        case .themePark: return "themepark"
        case .trainStation: return "trainstation"
        case .transitStation: return "transitstation"
        case .university: return "university"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "airport": self = .airport
        case "aquarium": self = .aquarium
        case "businesscampus": self = .businessCampus
        case "casino": self = .casino
        case "conventioncenter": self = .conventionCenter
        case "governmentfacility": self = .governmentFacility
        case "healthcarefacility": self = .healthcareFacility
        case "hotel": self = .hotel
        case "museum": self = .museum
        case "parkingfacility": self = .parkingFacility
        case "resort": self = .resort
        case "retailstore": self = .retailStore
        case "shoppingcenter": self = .shoppingCenter
        case "stadium": self = .stadium
        case "stripmall": self = .stripMall
        case "theater": self = .theater
        case "themepark": self = .themePark
        case "trainstation": self = .trainStation
        case "transitstation": self = .transitStation
        case "university": self = .university
        default: self = .unknown(rawValue)
        }
    }
}

// MARK: - Codable

extension VenueCategory: Codable {
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
