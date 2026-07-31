import XCTest
@testable import Presentation

@MainActor
final class DrawingDraftStateTests: XCTestCase {
    func test_whenCoordinateIsCreated_thenGeoJSONPositionUsesLongitudeLatitudeOrder() {
        // Given
        let coordinate = IMDFDraftCoordinate(longitude: 127.0276, latitude: 37.4979)

        // When
        let position = coordinate.geoJSONPosition

        // Then
        XCTAssertEqual(position, [127.0276, 37.4979])
    }

    func test_whenPointGeometryHasOneCoordinate_thenDraftCanFinish() {
        // Given
        let sut = makeSUT(geometry: .point)

        // When
        sut.append(.fixture())

        // Then
        XCTAssertTrue(sut.canFinish)
        XCTAssertEqual(sut.remainingPointCount, 0)
    }

    func test_whenLineGeometryHasOneCoordinate_thenDraftCannotFinish() {
        // Given
        let sut = makeSUT(geometry: .line)

        // When
        sut.append(.fixture())

        // Then
        XCTAssertFalse(sut.canFinish)
        XCTAssertEqual(sut.remainingPointCount, 1)
    }

    func test_whenPolygonGeometryHasThreeCoordinates_thenDraftCanFinish() {
        // Given
        let sut = makeSUT(geometry: .polygon)

        // When
        sut.append(.fixture(longitude: 127.0, latitude: 37.0))
        sut.append(.fixture(longitude: 127.1, latitude: 37.0))
        sut.append(.fixture(longitude: 127.1, latitude: 37.1))

        // Then
        XCTAssertTrue(sut.canFinish)
        XCTAssertEqual(sut.pointCount, 3)
    }

    func test_whenFormGeometryReceivesCoordinate_thenCoordinateIsIgnoredAndCanFinish() {
        // Given
        let sut = makeSUT(geometry: .form)

        // When
        sut.append(.fixture())

        // Then
        XCTAssertTrue(sut.canFinish)
        XCTAssertTrue(sut.coordinates.isEmpty)
    }

    func test_whenLastCoordinateIsRemoved_thenPointCountDecreases() {
        // Given
        let sut = makeSUT(geometry: .line)
        sut.append(.fixture(longitude: 127.0, latitude: 37.0))
        sut.append(.fixture(longitude: 127.1, latitude: 37.1))

        // When
        sut.removeLastCoordinate()

        // Then
        XCTAssertEqual(sut.coordinates, [.fixture(longitude: 127.0, latitude: 37.0)])
    }

    func test_whenDraftIsCleared_thenCoordinatesAreRemoved() {
        // Given
        let sut = makeSUT(geometry: .polygon)
        sut.append(.fixture())
        sut.append(.fixture(longitude: 127.1, latitude: 37.1))

        // When
        sut.clear()

        // Then
        XCTAssertTrue(sut.coordinates.isEmpty)
        XCTAssertEqual(sut.remainingPointCount, 3)
    }

    func test_whenGeometryChanges_thenDraftIsClearedAndMinimumPointCountChanges() {
        // Given
        let sut = makeSUT(geometry: .polygon)
        sut.append(.fixture())
        sut.append(.fixture(longitude: 127.1, latitude: 37.1))

        // When
        sut.setGeometry(.line)

        // Then
        XCTAssertEqual(sut.geometry, .line)
        XCTAssertTrue(sut.coordinates.isEmpty)
        XCTAssertEqual(sut.minimumPointCount, 2)
    }

    func test_whenDraftCannotFinish_thenFinishReturnsNil() {
        // Given
        let sut = makeSUT(geometry: .polygon)
        sut.append(.fixture())
        sut.append(.fixture(longitude: 127.1, latitude: 37.1))

        // When
        let result = sut.finish()

        // Then
        XCTAssertNil(result)
    }

    func test_whenDraftCanFinish_thenFinishReturnsGeometryAndCoordinates() throws {
        // Given
        let sut = makeSUT(geometry: .line)
        let first = IMDFDraftCoordinate.fixture(longitude: 127.0, latitude: 37.0)
        let second = IMDFDraftCoordinate.fixture(longitude: 127.1, latitude: 37.1)
        sut.append(first)
        sut.append(second)

        // When
        let result = try XCTUnwrap(sut.finish())

        // Then
        XCTAssertEqual(result.geometry, .line)
        XCTAssertEqual(result.coordinates, [first, second])
    }

    private func makeSUT(geometry: IMDFAuthoringGeometry) -> DrawingDraftState {
        DrawingDraftState(geometry: geometry)
    }
}

private extension IMDFDraftCoordinate {
    static func fixture(
        longitude: Double = 127.0276,
        latitude: Double = 37.4979
    ) -> Self {
        .init(longitude: longitude, latitude: latitude)
    }
}
