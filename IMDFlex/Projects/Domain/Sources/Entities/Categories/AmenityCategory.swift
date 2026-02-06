//
//  AmenityCategory.swift
//  Domain
//

import Foundation

/// IMDF Amenity categories
public enum AmenityCategory: Sendable, Equatable, Hashable {
    case atm
    case babyChanging
    case bench
    case chargingStation
    case drinkingWater
    case elevator
    case escalator
    case exhibit
    case fireExtinguisher
    case firstAid
    case fitnessEquipment
    case gate
    case information
    case locker
    case mail
    case movingWalkway
    case parking
    case phone
    case playground
    case ramp
    case recycling
    case restroom
    case restroomFamily
    case restroomFemale
    case restroomMale
    case restroomUnisex
    case seating
    case shower
    case smokingArea
    case stairs
    case steps
    case stroller
    case ticketMachine
    case trashCan
    case vendingMachine
    case wheelchair
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .atm: return "atm"
        case .babyChanging: return "babychanging"
        case .bench: return "bench"
        case .chargingStation: return "chargingstation"
        case .drinkingWater: return "drinkingwater"
        case .elevator: return "elevator"
        case .escalator: return "escalator"
        case .exhibit: return "exhibit"
        case .fireExtinguisher: return "fireextinguisher"
        case .firstAid: return "firstaid"
        case .fitnessEquipment: return "fitnessequipment"
        case .gate: return "gate"
        case .information: return "information"
        case .locker: return "locker"
        case .mail: return "mail"
        case .movingWalkway: return "movingwalkway"
        case .parking: return "parking"
        case .phone: return "phone"
        case .playground: return "playground"
        case .ramp: return "ramp"
        case .recycling: return "recycling"
        case .restroom: return "restroom"
        case .restroomFamily: return "restroom.family"
        case .restroomFemale: return "restroom.female"
        case .restroomMale: return "restroom.male"
        case .restroomUnisex: return "restroom.unisex"
        case .seating: return "seating"
        case .shower: return "shower"
        case .smokingArea: return "smokingarea"
        case .stairs: return "stairs"
        case .steps: return "steps"
        case .stroller: return "stroller"
        case .ticketMachine: return "ticketmachine"
        case .trashCan: return "trashcan"
        case .vendingMachine: return "vendingmachine"
        case .wheelchair: return "wheelchair"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "atm": self = .atm
        case "babychanging": self = .babyChanging
        case "bench": self = .bench
        case "chargingstation": self = .chargingStation
        case "drinkingwater": self = .drinkingWater
        case "elevator": self = .elevator
        case "escalator": self = .escalator
        case "exhibit": self = .exhibit
        case "fireextinguisher": self = .fireExtinguisher
        case "firstaid": self = .firstAid
        case "fitnessequipment": self = .fitnessEquipment
        case "gate": self = .gate
        case "information": self = .information
        case "locker": self = .locker
        case "mail": self = .mail
        case "movingwalkway": self = .movingWalkway
        case "parking": self = .parking
        case "phone": self = .phone
        case "playground": self = .playground
        case "ramp": self = .ramp
        case "recycling": self = .recycling
        case "restroom": self = .restroom
        case "restroom.family": self = .restroomFamily
        case "restroom.female": self = .restroomFemale
        case "restroom.male": self = .restroomMale
        case "restroom.unisex": self = .restroomUnisex
        case "seating": self = .seating
        case "shower": self = .shower
        case "smokingarea": self = .smokingArea
        case "stairs": self = .stairs
        case "steps": self = .steps
        case "stroller": self = .stroller
        case "ticketmachine": self = .ticketMachine
        case "trashcan": self = .trashCan
        case "vendingmachine": self = .vendingMachine
        case "wheelchair": self = .wheelchair
        default: self = .unknown(rawValue)
        }
    }
}

// MARK: - Codable

extension AmenityCategory: Codable {
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
