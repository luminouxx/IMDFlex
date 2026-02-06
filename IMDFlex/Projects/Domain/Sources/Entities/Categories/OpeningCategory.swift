//
//  OpeningCategory.swift
//  Domain
//

import Foundation

/// IMDF Opening categories
public enum OpeningCategory: Sendable, Equatable, Hashable {
    case door
    case emergencyExit
    case entranceExit
    case elevator
    case escalator
    case movingWalkway
    case ramp
    case stairs
    case steps
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .door: return "door"
        case .emergencyExit: return "emergencyexit"
        case .entranceExit: return "entranceexit"
        case .elevator: return "elevator"
        case .escalator: return "escalator"
        case .movingWalkway: return "movingwalkway"
        case .ramp: return "ramp"
        case .stairs: return "stairs"
        case .steps: return "steps"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "door": self = .door
        case "emergencyexit": self = .emergencyExit
        case "entranceexit": self = .entranceExit
        case "elevator": self = .elevator
        case "escalator": self = .escalator
        case "movingwalkway": self = .movingWalkway
        case "ramp": self = .ramp
        case "stairs": self = .stairs
        case "steps": self = .steps
        default: self = .unknown(rawValue)
        }
    }
}

// MARK: - Codable

extension OpeningCategory: Codable {
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

// MARK: - Door Info

/// Door-specific properties for Opening
public struct DoorInfo: Codable, Sendable, Equatable {
    public var type: DoorType?
    public var material: DoorMaterial?
    public var automatic: Bool?
    
    public init(type: DoorType? = nil, material: DoorMaterial? = nil, automatic: Bool? = nil) {
        self.type = type
        self.material = material
        self.automatic = automatic
    }
}

/// Door types
public enum DoorType: Sendable, Equatable, Hashable {
    case door
    case gate
    case movablePartition
    case open
    case revolving
    case shutter
    case sliding
    case swinging
    case turnstile
    case turnstileFullHeight
    case turnstileWaistHeight
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .door: return "door"
        case .gate: return "gate"
        case .movablePartition: return "movablepartition"
        case .open: return "open"
        case .revolving: return "revolving"
        case .shutter: return "shutter"
        case .sliding: return "sliding"
        case .swinging: return "swinging"
        case .turnstile: return "turnstile"
        case .turnstileFullHeight: return "turnstile.fullheight"
        case .turnstileWaistHeight: return "turnstile.waistheight"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "door": self = .door
        case "gate": self = .gate
        case "movablepartition": self = .movablePartition
        case "open": self = .open
        case "revolving": self = .revolving
        case "shutter": self = .shutter
        case "sliding": self = .sliding
        case "swinging": self = .swinging
        case "turnstile": self = .turnstile
        case "turnstile.fullheight": self = .turnstileFullHeight
        case "turnstile.waistheight": self = .turnstileWaistHeight
        default: self = .unknown(rawValue)
        }
    }
}

extension DoorType: Codable {
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

/// Door materials
public enum DoorMaterial: Sendable, Equatable, Hashable {
    case glass
    case metal
    case wood
    case unknown(String)
    
    public var rawValue: String {
        switch self {
        case .glass: return "glass"
        case .metal: return "metal"
        case .wood: return "wood"
        case .unknown(let value): return value
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "glass": self = .glass
        case "metal": self = .metal
        case "wood": self = .wood
        default: self = .unknown(rawValue)
        }
    }
}

extension DoorMaterial: Codable {
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
