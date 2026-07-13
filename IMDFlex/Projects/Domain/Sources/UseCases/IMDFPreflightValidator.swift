import Foundation

public protocol IMDFPreflightValidating: Sendable {
    func validate(_ venue: Venue) -> [IMDFPreflightIssue]
}

public struct IMDFPreflightValidator: IMDFPreflightValidating, Sendable {
    public init() {}

    public func validate(_ venue: Venue) -> [IMDFPreflightIssue] {
        var issues: [IMDFPreflightIssue] = []

        validateVenue(venue, issues: &issues)

        for building in venue.buildings {
            validateBuilding(building, issues: &issues)

            for level in building.levels {
                validateLevel(level, building: building, issues: &issues)
                validateUnits(in: level, issues: &issues)
            }
        }

        return issues
    }

    private func validateVenue(_ venue: Venue, issues: inout [IMDFPreflightIssue]) {
        if !isValidPolygon(venue.coordinates) {
            issues.append(
                .init(
                    code: .venueMissingPolygon,
                    severity: .warning,
                    feature: .venue,
                    featureID: venue.id,
                    message: "Venue should have an explicit polygon before Apple IMDF Sandbox validation."
                )
            )
        }

        if venue.address == nil {
            issues.append(
                .init(
                    code: .venueMissingAddress,
                    severity: .error,
                    feature: .venue,
                    featureID: venue.id,
                    message: "Venue must reference an address."
                )
            )
        }

        if venue.buildings.isEmpty {
            issues.append(
                .init(
                    code: .venueMissingBuilding,
                    severity: .error,
                    feature: .venue,
                    featureID: venue.id,
                    message: "Venue must contain at least one building."
                )
            )
        }
    }

    private func validateBuilding(_ building: Building, issues: inout [IMDFPreflightIssue]) {
        guard let footprint = building.footprint else {
            issues.append(
                .init(
                    code: .buildingMissingFootprint,
                    severity: .error,
                    feature: .building,
                    featureID: building.id,
                    message: "Building must have at least one footprint."
                )
            )
            return
        }

        if !isValidPolygon(footprint.coordinates) {
            issues.append(
                .init(
                    code: .footprintInvalidPolygon,
                    severity: .error,
                    feature: .footprint,
                    featureID: footprint.id,
                    message: "Footprint must have at least three polygon coordinates."
                )
            )
        }
    }

    private func validateLevel(
        _ level: Level,
        building: Building,
        issues: inout [IMDFPreflightIssue]
    ) {
        if level.shortName?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            issues.append(
                .init(
                    code: .levelMissingShortName,
                    severity: .error,
                    feature: .level,
                    featureID: level.id,
                    message: "Level must have a short name."
                )
            )
        }

        let hasLevelPolygon = isValidPolygon(level.coordinates)
        let hasFootprintFallback = building.footprint.map { isValidPolygon($0.coordinates) } ?? false

        if !hasLevelPolygon && !hasFootprintFallback {
            issues.append(
                .init(
                    code: .levelMissingPolygon,
                    severity: .error,
                    feature: .level,
                    featureID: level.id,
                    message: "Level must have polygon coordinates or a valid building footprint fallback."
                )
            )
        }

        if level.units.isEmpty {
            issues.append(
                .init(
                    code: .levelMissingUnit,
                    severity: .error,
                    feature: .level,
                    featureID: level.id,
                    message: "Level must be referenced by at least one unit."
                )
            )
        }
    }

    private func validateUnits(in level: Level, issues: inout [IMDFPreflightIssue]) {
        for unit in level.units {
            if !isValidPolygon(unit.coordinates) {
                issues.append(
                    .init(
                        code: .unitInvalidPolygon,
                        severity: .error,
                        feature: .unit,
                        featureID: unit.id,
                        message: "Unit must have at least three polygon coordinates."
                    )
                )
            }

            for occupant in unit.occupants {
                validateOccupant(occupant, issues: &issues)
            }
        }
    }

    private func validateOccupant(_ occupant: Occupant, issues: inout [IMDFPreflightIssue]) {
        if occupant.category == nil {
            issues.append(
                .init(
                    code: .occupantMissingCategory,
                    severity: .error,
                    feature: .occupant,
                    featureID: occupant.id,
                    message: "Occupant must have a category."
                )
            )
        }

        issues.append(
            .init(
                code: .occupantAnchorUnsupported,
                severity: .error,
                feature: .occupant,
                featureID: occupant.id,
                message: "Occupant export requires anchor support, which is not implemented yet."
            )
        )
    }

    private func isValidPolygon(_ coordinates: [Coordinate]) -> Bool {
        uniqueCoordinates(in: coordinates).count >= 3
    }

    private func uniqueCoordinates(in coordinates: [Coordinate]) -> [Coordinate] {
        coordinates.reduce(into: []) { result, coordinate in
            if !result.contains(coordinate) {
                result.append(coordinate)
            }
        }
    }
}

public struct IMDFPreflightIssue: Identifiable, Equatable, Sendable {
    public let code: IMDFPreflightIssueCode
    public let severity: IMDFPreflightSeverity
    public let feature: IMDFPreflightFeature
    public let featureID: UUID?
    public let message: String

    public var id: String {
        [
            code.rawValue,
            feature.rawValue,
            featureID?.uuidString ?? "archive"
        ].joined(separator: ":")
    }

    public init(
        code: IMDFPreflightIssueCode,
        severity: IMDFPreflightSeverity,
        feature: IMDFPreflightFeature,
        featureID: UUID?,
        message: String
    ) {
        self.code = code
        self.severity = severity
        self.feature = feature
        self.featureID = featureID
        self.message = message
    }
}

public enum IMDFPreflightIssueCode: String, Codable, CaseIterable, Sendable {
    case venueMissingPolygon
    case venueMissingAddress
    case venueMissingBuilding
    case buildingMissingFootprint
    case footprintInvalidPolygon
    case levelMissingShortName
    case levelMissingPolygon
    case levelMissingUnit
    case unitInvalidPolygon
    case occupantMissingCategory
    case occupantAnchorUnsupported
}

public enum IMDFPreflightSeverity: String, Codable, CaseIterable, Sendable {
    case warning
    case error
}

public enum IMDFPreflightFeature: String, Codable, CaseIterable, Sendable {
    case venue
    case building
    case footprint
    case level
    case unit
    case occupant
}
