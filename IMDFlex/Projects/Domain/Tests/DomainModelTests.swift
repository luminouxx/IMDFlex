import Foundation
import XCTest
@testable import Domain

final class DomainModelTests: XCTestCase {
    func testVenuePreservesNestedIMDFEntityRelationships() throws {
        let unit = Unit(
            id: try uuid("00000000-0000-0000-0000-000000000001"),
            name: "Lobby",
            category: .lobby,
            coordinates: squareCoordinates()
        )
        let level = Level(
            id: try uuid("00000000-0000-0000-0000-000000000002"),
            name: "Level 1",
            category: .unspecified,
            ordinal: 0,
            shortName: "1F",
            coordinates: squareCoordinates(),
            units: [unit]
        )
        let footprint = Footprint(
            id: try uuid("00000000-0000-0000-0000-000000000003"),
            category: .ground,
            coordinates: squareCoordinates()
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
        let venue = Venue(
            id: try uuid("00000000-0000-0000-0000-000000000006"),
            name: "IMDFlex Test Venue",
            category: .university,
            coordinates: squareCoordinates(),
            buildings: [building],
            address: address
        )

        XCTAssertEqual(venue.coordinates, squareCoordinates())
        XCTAssertEqual(venue.buildings.first?.id, building.id)
        XCTAssertEqual(venue.buildings.first?.category, .unspecified)
        XCTAssertEqual(venue.buildings.first?.levels.first?.id, level.id)
        XCTAssertEqual(venue.buildings.first?.levels.first?.category, .unspecified)
        XCTAssertEqual(venue.buildings.first?.levels.first?.coordinates, squareCoordinates())
        XCTAssertEqual(venue.buildings.first?.levels.first?.units.first?.id, unit.id)
        XCTAssertEqual(venue.buildings.first?.footprint?.id, footprint.id)
        XCTAssertEqual(venue.buildings.first?.footprint?.category, .ground)
        XCTAssertEqual(venue.address?.id, address.id)
    }

    func testCoordinateEqualityUsesLatitudeAndLongitude() {
        let coordinate = Coordinate(latitude: 37.33182, longitude: -122.03118)

        XCTAssertEqual(coordinate, Coordinate(latitude: 37.33182, longitude: -122.03118))
        XCTAssertNotEqual(coordinate, Coordinate(latitude: 37.33182, longitude: -122.03119))
        XCTAssertNotEqual(coordinate, Coordinate(latitude: 37.33183, longitude: -122.03118))
    }

    func testFootprintPreservesAuthoredPolygonCoordinates() {
        let coordinates = squareCoordinates()
        let footprint = Footprint(coordinates: coordinates)

        XCTAssertEqual(footprint.coordinates, coordinates)
        XCTAssertEqual(footprint.coordinates.count, 4)
        XCTAssertNotEqual(footprint.coordinates.first, footprint.coordinates.last)
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
}
