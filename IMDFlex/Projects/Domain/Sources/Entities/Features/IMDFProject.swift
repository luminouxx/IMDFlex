//
//  IMDFProject.swift
//  Domain
//

import Foundation

/// App-level project for managing IMDF data
public struct IMDFProject: Identifiable, Codable, Sendable, Equatable, Hashable {
    public let id: UUID
    public var name: String
    public var description: String?
    public var thumbnail: Data?
    public var createdAt: Date
    public var updatedAt: Date
    
    public init(
        id: UUID = UUID(),
        name: String,
        description: String? = nil,
        thumbnail: Data? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    /// Directory name for file storage
    public var directoryName: String {
        id.uuidString
    }
}
