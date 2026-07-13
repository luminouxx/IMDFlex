import Foundation
import XCTest
@testable import Domain

final class DomainModelTests: XCTestCase {
    func test_whenVenueIsCreatedWithNestedEntities_thenItPreservesIMDFRelationships() throws {
        // Given
        let coordinates = squareCoordinates()
        let unit = Unit(
            id: try uuid("00000000-0000-0000-0000-000000000001"),
            name: "Lobby",
            category: .lobby,
            coordinates: coordinates
        )
        let detail = Detail(
            id: try uuid("00000000-0000-0000-0000-000000000007"),
            name: "Wall Detail",
            coordinates: lineCoordinates()
        )
        let fixture = Fixture(
            id: try uuid("00000000-0000-0000-0000-000000000008"),
            name: "Desk",
            category: .desk,
            coordinates: coordinates
        )
        let geofence = Geofence(
            id: try uuid("00000000-0000-0000-0000-000000000009"),
            name: "Paid Area",
            category: .paidArea,
            coordinates: coordinates
        )
        let kiosk = Kiosk(
            id: try uuid("00000000-0000-0000-0000-000000000010"),
            name: "Info Kiosk",
            coordinates: coordinates
        )
        let section = Section(
            id: try uuid("00000000-0000-0000-0000-000000000011"),
            name: "Gate Area",
            category: .gateArea,
            coordinates: coordinates
        )
        let level = Level(
            id: try uuid("00000000-0000-0000-0000-000000000002"),
            name: "Level 1",
            category: .unspecified,
            ordinal: 0,
            shortName: "1F",
            coordinates: coordinates,
            units: [unit],
            details: [detail],
            fixtures: [fixture],
            geofences: [geofence],
            kiosks: [kiosk],
            sections: [section]
        )
        let footprint = Footprint(
            id: try uuid("00000000-0000-0000-0000-000000000003"),
            category: .ground,
            coordinates: coordinates
        )
        let building = Building(
            id: try uuid("00000000-0000-0000-0000-000000000004"),
            name: "Main Building",
            category: .unspecified,
            levels: [level],
            footprint: footprint
        )
        let address = Address(
            id: try uuid("00000000-0000-0000-0000-000000000005"),
            address: "1 Infinite Loop",
            locality: "Cupertino",
            province: "CA",
            country: "US",
            postalCode: "95014"
        )
        let relationship = Relationship(
            id: try uuid("00000000-0000-0000-0000-000000000012"),
            category: .stairs,
            originID: unit.id,
            destinationID: section.id
        )

        // When
        let venue = Venue(
            id: try uuid("00000000-0000-0000-0000-000000000006"),
            name: "IMDFlex Test Venue",
            category: .university,
            coordinates: coordinates,
            buildings: [building],
            address: address,
            relationships: [relationship]
        )

        // Then
        XCTAssertEqual(venue.coordinates, coordinates)
        XCTAssertEqual(venue.buildings.first?.id, building.id)
        XCTAssertEqual(venue.buildings.first?.category, .unspecified)
        XCTAssertEqual(venue.buildings.first?.levels.first?.id, level.id)
        XCTAssertEqual(venue.buildings.first?.levels.first?.category, .unspecified)
        XCTAssertEqual(venue.buildings.first?.levels.first?.coordinates, coordinates)
        XCTAssertEqual(venue.buildings.first?.levels.first?.units.first?.id, unit.id)
        XCTAssertEqual(venue.buildings.first?.levels.first?.details.first?.id, detail.id)
        XCTAssertEqual(venue.buildings.first?.levels.first?.fixtures.first?.id, fixture.id)
        XCTAssertEqual(venue.buildings.first?.levels.first?.geofences.first?.id, geofence.id)
        XCTAssertEqual(venue.buildings.first?.levels.first?.kiosks.first?.id, kiosk.id)
        XCTAssertEqual(venue.buildings.first?.levels.first?.sections.first?.id, section.id)
        XCTAssertEqual(venue.buildings.first?.footprint?.id, footprint.id)
        XCTAssertEqual(venue.buildings.first?.footprint?.category, .ground)
        XCTAssertEqual(venue.address?.id, address.id)
        XCTAssertEqual(venue.relationships.first?.id, relationship.id)
    }

    func test_whenCoordinatesShareLatitudeAndLongitude_thenTheyAreEqual() {
        // Given
        let coordinate = Coordinate(latitude: 37.33182, longitude: -122.03118)

        // When
        let equalCoordinate = Coordinate(latitude: 37.33182, longitude: -122.03118)
        let differentLongitude = Coordinate(latitude: 37.33182, longitude: -122.03119)
        let differentLatitude = Coordinate(latitude: 37.33183, longitude: -122.03118)

        // Then
        XCTAssertEqual(coordinate, equalCoordinate)
        XCTAssertNotEqual(coordinate, differentLongitude)
        XCTAssertNotEqual(coordinate, differentLatitude)
    }

    func test_whenFootprintIsCreatedWithPolygonCoordinates_thenItPreservesAuthoredCoordinates() {
        // Given
        let coordinates = squareCoordinates()

        // When
        let footprint = Footprint(coordinates: coordinates)

        // Then
        XCTAssertEqual(footprint.coordinates, coordinates)
        XCTAssertEqual(footprint.coordinates.count, 4)
        XCTAssertNotEqual(footprint.coordinates.first, footprint.coordinates.last)
    }

    func test_whenMVPFeatureCategoriesAreUsed_thenRawValuesMatchAppleIMDFCategories() {
        // Given
        let categories: [String] = [
            VenueCategory.shoppingCenter.rawValue,
            BuildingCategory.unspecified.rawValue,
            FootprintCategory.ground.rawValue,
            LevelCategory.unspecified.rawValue,
            UnitCategory.foodService.rawValue,
            UnitCategory.walkway.rawValue,
            UnitCategory.structure.rawValue,
            OpeningCategory.emergencyExit.rawValue,
            OpeningCategory.principalPedestrian.rawValue,
            AccessControl.keyAccess.rawValue,
            AccessControl.badgeReader.rawValue,
            AmenityCategory.restroomMale.rawValue,
            AmenityCategory.drinkingWater.rawValue,
            AmenityCategory.chargingStation.rawValue,
            AmenityCategory.firstAid.rawValue,
            OccupantCategory.retail.rawValue,
            OccupantCategory.office.rawValue,
            OccupantCategory.medical.rawValue,
            OccupantCategory.government.rawValue,
            OccupantCategory.entertainment.rawValue,
            OccupantCategory.service.rawValue,
            FixtureCategory.desk.rawValue,
            FixtureCategory.checkInDesk.rawValue,
            GeofenceCategory.paidArea.rawValue,
            RelationshipCategory.movingWalkway.rawValue,
            RelationshipCategory.traversalPath.rawValue,
            SectionCategory.gateArea.rawValue,
            SectionCategory.postSecurity.rawValue
        ]

        // When
        let expectedAppleCategoryValues = [
            "shoppingcenter",
            "unspecified",
            "ground",
            "unspecified",
            "foodservice",
            "walkway",
            "structure",
            "emergencyexit",
            "pedestrian.principal",
            "keyaccess",
            "badgereader",
            "restroom.male",
            "drinkingfountain",
            "powerchargingstation",
            "firstaid",
            "shopping",
            "corporateoffices",
            "medicalcenter",
            "publicservices.government",
            "arts.entertainment",
            "localservices",
            "desk",
            "checkin.desk",
            "paidarea",
            "movingwalkway",
            "traversal.path",
            "gatearea",
            "postsecurity"
        ]

        // Then
        XCTAssertEqual(categories, expectedAppleCategoryValues)
    }

    private func uuid(_ string: String) throws -> UUID {
        try XCTUnwrap(UUID(uuidString: string))
    }

    private func squareCoordinates() -> [Coordinate] {
        [
            Coordinate(latitude: 37.33170, longitude: -122.03110),
            Coordinate(latitude: 37.33170, longitude: -122.03090),
            Coordinate(latitude: 37.33190, longitude: -122.03090),
            Coordinate(latitude: 37.33190, longitude: -122.03110)
        ]
    }

    private func lineCoordinates() -> [Coordinate] {
        [
            Coordinate(latitude: 37.33175, longitude: -122.03105),
            Coordinate(latitude: 37.33185, longitude: -122.03100)
        ]
    }
}
