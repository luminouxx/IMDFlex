//
//  UnitCategory.swift
//  Domain
//

import Foundation

/// IMDF Unit categories
public enum UnitCategory: Sendable, Equatable, Hashable {
    case auditorium
    case brick
    case classroom
    case column
    case concrete
    case conferenceRoom
    case drywall
    case elevator
    case escalator
    case fieldOfPlay
    case firstAid
    case fitnessRoom
    case foodService
    case footbridge
    case glass
    case huddleRoom
    case kitchen
    case laboratory
    case library
    case lobby
    case lounge
    case mailRoom
    case mothersRoom
    case movieTheater
    case movingWalkway
    case nonPublic
    case office
    case openToBelow
    case parking
    case phoneRoom
    case platform
    case privateLounge
    case ramp
    case recreation
    case restroom
    case restroomFamily
    case restroomFemale
    case restroomFemaleAccessible
    case restroomMale
    case restroomMaleAccessible
    case restroomTransgender
    case restroomTransgenderAccessible
    case restroomUnisex
    case restroomUnisexAccessible
    case road
    case room
    case serverRoom
    case shop
    case shower
    case smokingArea
    case stairs
    case steps
    case storage
    case structure
    case terrace
    case theater
    case unenclosedArea
    case unspecified
    case vegetation
    case waitingRoom
    case walkway
    case wood
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .auditorium: return "auditorium"
        case .brick: return "brick"
        case .classroom: return "classroom"
        case .column: return "column"
        case .concrete: return "concrete"
        case .conferenceRoom: return "conferenceroom"
        case .drywall: return "drywall"
        case .elevator: return "elevator"
        case .escalator: return "escalator"
        case .fieldOfPlay: return "fieldofplay"
        case .firstAid: return "firstaid"
        case .fitnessRoom: return "fitnessroom"
        case .foodService: return "foodservice"
        case .footbridge: return "footbridge"
        case .glass: return "glass"
        case .huddleRoom: return "huddleroom"
        case .kitchen: return "kitchen"
        case .laboratory: return "laboratory"
        case .library: return "library"
        case .lobby: return "lobby"
        case .lounge: return "lounge"
        case .mailRoom: return "mailroom"
        case .mothersRoom: return "mothersroom"
        case .movieTheater: return "movietheater"
        case .movingWalkway: return "movingwalkway"
        case .nonPublic: return "nonpublic"
        case .office: return "office"
        case .openToBelow: return "opentobelow"
        case .parking: return "parking"
        case .phoneRoom: return "phoneroom"
        case .platform: return "platform"
        case .privateLounge: return "privatelounge"
        case .ramp: return "ramp"
        case .recreation: return "recreation"
        case .restroom: return "restroom"
        case .restroomFamily: return "restroom.family"
        case .restroomFemale: return "restroom.female"
        case .restroomFemaleAccessible: return "restroom.female.accessible"
        case .restroomMale: return "restroom.male"
        case .restroomMaleAccessible: return "restroom.male.accessible"
        case .restroomTransgender: return "restroom.transgender"
        case .restroomTransgenderAccessible: return "restroom.transgender.accessible"
        case .restroomUnisex: return "restroom.unisex"
        case .restroomUnisexAccessible: return "restroom.unisex.accessible"
        case .road: return "road"
        case .room: return "room"
        case .serverRoom: return "serverroom"
        case .shop: return "shop"
        case .shower: return "shower"
        case .smokingArea: return "smokingarea"
        case .stairs: return "stairs"
        case .steps: return "steps"
        case .storage: return "storage"
        case .structure: return "structure"
        case .terrace: return "terrace"
        case .theater: return "theater"
        case .unenclosedArea: return "unenclosedarea"
        case .unspecified: return "unspecified"
        case .vegetation: return "vegetation"
        case .waitingRoom: return "waitingroom"
        case .walkway: return "walkway"
        case .wood: return "wood"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "auditorium": self = .auditorium
        case "brick": self = .brick
        case "classroom": self = .classroom
        case "column": self = .column
        case "concrete": self = .concrete
        case "conferenceroom": self = .conferenceRoom
        case "drywall": self = .drywall
        case "elevator": self = .elevator
        case "escalator": self = .escalator
        case "fieldofplay": self = .fieldOfPlay
        case "firstaid": self = .firstAid
        case "fitnessroom": self = .fitnessRoom
        case "foodservice": self = .foodService
        case "footbridge": self = .footbridge
        case "glass": self = .glass
        case "huddleroom": self = .huddleRoom
        case "kitchen": self = .kitchen
        case "laboratory": self = .laboratory
        case "library": self = .library
        case "lobby": self = .lobby
        case "lounge": self = .lounge
        case "mailroom": self = .mailRoom
        case "mothersroom": self = .mothersRoom
        case "movietheater": self = .movieTheater
        case "movingwalkway": self = .movingWalkway
        case "nonpublic": self = .nonPublic
        case "office": self = .office
        case "opentobelow": self = .openToBelow
        case "parking": self = .parking
        case "phoneroom": self = .phoneRoom
        case "platform": self = .platform
        case "privatelounge": self = .privateLounge
        case "ramp": self = .ramp
        case "recreation": self = .recreation
        case "restroom": self = .restroom
        case "restroom.family": self = .restroomFamily
        case "restroom.female": self = .restroomFemale
        case "restroom.female.accessible": self = .restroomFemaleAccessible
        case "restroom.male": self = .restroomMale
        case "restroom.male.accessible": self = .restroomMaleAccessible
        case "restroom.transgender": self = .restroomTransgender
        case "restroom.transgender.accessible": self = .restroomTransgenderAccessible
        case "restroom.unisex": self = .restroomUnisex
        case "restroom.unisex.accessible": self = .restroomUnisexAccessible
        case "road": self = .road
        case "room": self = .room
        case "serverroom": self = .serverRoom
        case "shop": self = .shop
        case "shower": self = .shower
        case "smokingarea": self = .smokingArea
        case "stairs": self = .stairs
        case "steps": self = .steps
        case "storage": self = .storage
        case "structure": self = .structure
        case "terrace": self = .terrace
        case "theater": self = .theater
        case "unenclosedarea": self = .unenclosedArea
        case "unspecified": self = .unspecified
        case "vegetation": self = .vegetation
        case "waitingroom": self = .waitingRoom
        case "walkway": self = .walkway
        case "wood": self = .wood
        default: self = .unknown(rawValue)
        }
    }
}

// MARK: - Codable

extension UnitCategory: Codable {
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
