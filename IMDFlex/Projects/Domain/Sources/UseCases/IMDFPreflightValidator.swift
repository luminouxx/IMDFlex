import Foundation

public protocol IMDFPreflightValidating: Sendable {
    func validate(_ venue: Venue) -> [IMDFPreflightIssue]
}

public struct IMDFPreflightValidator: IMDFPreflightValidating, Sendable {
    public init() {}

    public func validate(_ venue: Venue) -> [IMDFPreflightIssue] {
        var issues: [IMDFPreflightIssue] = []
        let featureIDs = collectFeatureIDs(in: venue)

        validateVenue(venue, issues: &issues)
        validateRelationships(venue.relationships, featureIDs: featureIDs, issues: &issues)

        for building in venue.buildings {
            validateBuilding(building, issues: &issues)

            for level in building.levels {
                validateLevel(level, building: building, issues: &issues)
                validateUnits(in: level, issues: &issues)
                validateLevelFeatureCollections(in: level, issues: &issues)
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
                validateOccupant(occupant, anchors: unit.anchors, issues: &issues)
            }
        }
    }

    private func validateLevelFeatureCollections(in level: Level, issues: inout [IMDFPreflightIssue]) {
        for detail in level.details where !isValidLine(detail.coordinates) {
            issues.append(
                .init(
                    code: .detailInvalidLine,
                    severity: .error,
                    feature: .detail,
                    featureID: detail.id,
                    message: "Detail must have at least two line coordinates."
                )
            )
        }

        for fixture in level.fixtures where !isValidPolygon(fixture.coordinates) {
            issues.append(
                .init(
                    code: .fixtureInvalidPolygon,
                    severity: .error,
                    feature: .fixture,
                    featureID: fixture.id,
                    message: "Fixture must have at least three polygon coordinates."
                )
            )
        }

        for geofence in level.geofences where !isValidPolygon(geofence.coordinates) {
            issues.append(
                .init(
                    code: .geofenceInvalidPolygon,
                    severity: .error,
                    feature: .geofence,
                    featureID: geofence.id,
                    message: "Geofence must have at least three polygon coordinates."
                )
            )
        }

        for kiosk in level.kiosks where !isValidPolygon(kiosk.coordinates) {
            issues.append(
                .init(
                    code: .kioskInvalidPolygon,
                    severity: .error,
                    feature: .kiosk,
                    featureID: kiosk.id,
                    message: "Kiosk must have at least three polygon coordinates."
                )
            )
        }

        for section in level.sections where !isValidPolygon(section.coordinates) {
            issues.append(
                .init(
                    code: .sectionInvalidPolygon,
                    severity: .error,
                    feature: .section,
                    featureID: section.id,
                    message: "Section must have at least three polygon coordinates."
                )
            )
        }
    }

    private func validateRelationships(
        _ relationships: [Relationship],
        featureIDs: Set<UUID>,
        issues: inout [IMDFPreflightIssue]
    ) {
        for relationship in relationships {
            if relationship.originID == relationship.destinationID {
                issues.append(
                    .init(
                        code: .relationshipSelfReference,
                        severity: .error,
                        feature: .relationship,
                        featureID: relationship.id,
                        message: "Relationship origin and destination must reference different features."
                    )
                )
            }

            if !featureIDs.contains(relationship.originID) || !featureIDs.contains(relationship.destinationID) {
                issues.append(
                    .init(
                        code: .relationshipEndpointNotFound,
                        severity: .error,
                        feature: .relationship,
                        featureID: relationship.id,
                        message: "Relationship origin and destination references must resolve to authored features."
                    )
                )
            }
        }
    }

    private func validateOccupant(
        _ occupant: Occupant,
        anchors: [Anchor],
        issues: inout [IMDFPreflightIssue]
    ) {
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

        guard let anchorID = occupant.anchorID else {
            issues.append(
                .init(
                    code: .occupantMissingAnchor,
                    severity: .error,
                    feature: .occupant,
                    featureID: occupant.id,
                    message: "Occupant must reference an anchor."
                )
            )
            return
        }

        if !anchors.contains(where: { $0.id == anchorID }) {
            issues.append(
                .init(
                    code: .occupantAnchorNotFound,
                    severity: .error,
                    feature: .anchor,
                    featureID: anchorID,
                    message: "Occupant anchor reference must resolve to an anchor in the same unit."
                )
            )
        }
    }

    private func isValidPolygon(_ coordinates: [Coordinate]) -> Bool {
        uniqueCoordinates(in: coordinates).count >= 3
    }

    private func isValidLine(_ coordinates: [Coordinate]) -> Bool {
        uniqueCoordinates(in: coordinates).count >= 2
    }

    private func uniqueCoordinates(in coordinates: [Coordinate]) -> [Coordinate] {
        coordinates.reduce(into: []) { result, coordinate in
            if !result.contains(coordinate) {
                result.append(coordinate)
            }
        }
    }

    private func collectFeatureIDs(in venue: Venue) -> Set<UUID> {
        var ids: Set<UUID> = [venue.id]

        if let address = venue.address {
            ids.insert(address.id)
        }

        for building in venue.buildings {
            ids.insert(building.id)

            if let footprint = building.footprint {
                ids.insert(footprint.id)
            }

            for level in building.levels {
                ids.insert(level.id)
                ids.formUnion(level.units.flatMap { unit in
                    [unit.id]
                        + unit.anchors.map(\.id)
                        + unit.amenities.map(\.id)
                        + unit.occupants.map(\.id)
                })
                ids.formUnion(level.openings.map(\.id))
                ids.formUnion(level.details.map(\.id))
                ids.formUnion(level.fixtures.map(\.id))
                ids.formUnion(level.geofences.map(\.id))
                ids.formUnion(level.kiosks.map(\.id))
                ids.formUnion(level.sections.map(\.id))
            }
        }

        return ids
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
    case occupantMissingAnchor
    case occupantAnchorNotFound
    case detailInvalidLine
    case fixtureInvalidPolygon
    case geofenceInvalidPolygon
    case kioskInvalidPolygon
    case relationshipEndpointNotFound
    case relationshipSelfReference
    case sectionInvalidPolygon
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
    case anchor
    case occupant
    case detail
    case fixture
    case geofence
    case kiosk
    case relationship
    case section
}
