import Foundation
import XCTest
@testable import Domain

final class IMDFPreflightValidatorTests: XCTestCase {
    func test_whenVenueHasRequiredMVPData_thenValidatorReturnsNoIssues() {
        // Given
        let sut = makeSUT()
        let venue = makeVenueFixture()

        // When
        let issues = sut.validate(venue)

        // Then
        XCTAssertTrue(issues.isEmpty)
    }

    func test_whenVenueMissesTopLevelRequirements_thenValidatorReturnsVenueIssues() {
        // Given
        let sut = makeSUT()
        let venue = Venue(
            name: "Invalid Venue",
            category: .university,
            coordinates: []
        )

        // When
        let issues = sut.validate(venue)

        // Then
        XCTAssertEqual(issueCodes(in: issues), [.venueMissingPolygon, .venueMissingAddress, .venueMissingBuilding])
        XCTAssertTrue(issues.allSatisfy { $0.feature == .venue })
    }

    func test_whenBuildingAndFootprintAreInvalid_thenValidatorReturnsBuildingAndFootprintIssues() {
        // Given
        let sut = makeSUT()
        let buildingWithoutFootprint = Building(name: "Missing Footprint")
        let buildingWithInvalidFootprint = Building(
            name: "Invalid Footprint",
            footprint: Footprint(coordinates: [Coordinate(latitude: 37.0, longitude: -122.0)])
        )
        let venue = makeVenueFixture(buildings: [buildingWithoutFootprint, buildingWithInvalidFootprint])

        // When
        let issues = sut.validate(venue)

        // Then
        XCTAssertEqual(issueCodes(in: issues), [.buildingMissingFootprint, .footprintInvalidPolygon])
        XCTAssertEqual(issues.map(\.feature), [.building, .footprint])
    }

    func test_whenLevelIsMissingRequiredExportData_thenValidatorReturnsLevelIssues() {
        // Given
        let sut = makeSUT()
        let level = Level(
            name: "Level 1",
            ordinal: 0,
            shortName: " ",
            coordinates: [],
            units: []
        )
        let building = Building(name: "Main", levels: [level], footprint: nil)
        let venue = makeVenueFixture(buildings: [building])

        // When
        let issues = sut.validate(venue)

        // Then
        XCTAssertEqual(
            issueCodes(in: issues),
            [.buildingMissingFootprint, .levelMissingShortName, .levelMissingPolygon, .levelMissingUnit]
        )
        XCTAssertTrue(issues.contains { $0.feature == .level && $0.featureID == level.id })
    }

    func test_whenLevelHasNoCoordinatesButBuildingHasValidFootprint_thenValidatorAcceptsFallbackGeometry() {
        // Given
        let sut = makeSUT()
        let level = Level(
            name: "Level 1",
            ordinal: 0,
            shortName: "1F",
            coordinates: [],
            units: [makeUnitFixture()]
        )
        let building = Building(name: "Main", levels: [level], footprint: makeFootprintFixture())
        let venue = makeVenueFixture(buildings: [building])

        // When
        let issues = sut.validate(venue)

        // Then
        XCTAssertFalse(issues.contains { $0.code == .levelMissingPolygon })
    }

    func test_whenUnitAndOccupantAreInvalid_thenValidatorReturnsUnitAndOccupantIssues() {
        // Given
        let sut = makeSUT()
        let occupant = Occupant(name: "Tenant")
        let unit = Domain.Unit(
            name: "Invalid Unit",
            category: .room,
            coordinates: [],
            occupants: [occupant]
        )
        let level = Level(
            name: "Level 1",
            ordinal: 0,
            shortName: "1F",
            coordinates: squareCoordinates(),
            units: [unit]
        )
        let building = Building(name: "Main", levels: [level], footprint: makeFootprintFixture())
        let venue = makeVenueFixture(buildings: [building])

        // When
        let issues = sut.validate(venue)

        // Then
        XCTAssertEqual(issueCodes(in: issues), [.unitInvalidPolygon, .occupantMissingCategory, .occupantAnchorUnsupported])
        XCTAssertEqual(issues.map(\.feature), [.unit, .occupant, .occupant])
        XCTAssertTrue(issues.contains { $0.featureID == occupant.id })
    }

    func test_whenIssueIsCreated_thenIDIncludesCodeFeatureAndFeatureID() throws {
        // Given
        let featureID = try XCTUnwrap(UUID(uuidString: "00000000-0000-0000-0000-000000000017"))
        let issue = IMDFPreflightIssue(
            code: .venueMissingAddress,
            severity: .error,
            feature: .venue,
            featureID: featureID,
            message: "Venue must reference an address."
        )

        // When
        let id = issue.id

        // Then
        XCTAssertEqual(id, "venueMissingAddress:venue:00000000-0000-0000-0000-000000000017")
    }

    private func makeSUT() -> IMDFPreflightValidator {
        IMDFPreflightValidator()
    }

    private func makeVenueFixture(buildings: [Building]? = nil) -> Venue {
        Venue(
            name: "Valid Venue",
            category: .university,
            coordinates: squareCoordinates(),
            buildings: buildings ?? [makeBuildingFixture()],
            address: Address(
                address: "1 Infinite Loop",
                locality: "Cupertino",
                province: "CA",
                country: "US",
                postalCode: "95014"
            )
        )
    }

    private func makeBuildingFixture() -> Building {
        Building(
            name: "Main",
            levels: [
                Level(
                    name: "Level 1",
                    ordinal: 0,
                    shortName: "1F",
                    coordinates: squareCoordinates(),
                    units: [makeUnitFixture()]
                )
            ],
            footprint: makeFootprintFixture()
        )
    }

    private func makeFootprintFixture() -> Footprint {
        Footprint(coordinates: squareCoordinates())
    }

    private func makeUnitFixture() -> Domain.Unit {
        Domain.Unit(name: "Lobby", category: .lobby, coordinates: squareCoordinates())
    }

    private func squareCoordinates() -> [Coordinate] {
        [
            Coordinate(latitude: 37.33170, longitude: -122.03110),
            Coordinate(latitude: 37.33170, longitude: -122.03090),
            Coordinate(latitude: 37.33190, longitude: -122.03090),
            Coordinate(latitude: 37.33190, longitude: -122.03110)
        ]
    }

    private func issueCodes(in issues: [IMDFPreflightIssue]) -> [IMDFPreflightIssueCode] {
        issues.map(\.code)
    }
}
