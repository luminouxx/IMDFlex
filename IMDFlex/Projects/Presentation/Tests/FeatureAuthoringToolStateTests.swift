import XCTest
@testable import Presentation
import Domain

@MainActor
final class FeatureAuthoringToolStateTests: XCTestCase {
    func test_whenAllFeaturesAreListed_thenTheyCoverAllMVPAuthoringFeatures() {
        // Given
        let features = IMDFAuthoringFeature.allCases

        // When
        let featureNames = features.map(\.rawValue)

        // Then
        XCTAssertEqual(
            featureNames,
            [
                "address",
                "venue",
                "building",
                "footprint",
                "level",
                "unit",
                "opening",
                "amenity",
                "anchor",
                "occupant",
                "detail",
                "fixture",
                "geofence",
                "kiosk",
                "relationship",
                "section"
            ]
        )
    }

    func test_whenFeatureContractsAreRead_thenTheyExposeGeometryCategoryAndCatalogMapping() {
        // Given
        let unit = IMDFAuthoringFeature.unit.contract
        let opening = IMDFAuthoringFeature.opening.contract
        let amenity = IMDFAuthoringFeature.amenity.contract
        let occupant = IMDFAuthoringFeature.occupant.contract
        let relationship = IMDFAuthoringFeature.relationship.contract

        // When
        let geometryByFeature = [
            unit.feature: unit.geometry,
            opening.feature: opening.geometry,
            amenity.feature: amenity.geometry,
            occupant.feature: occupant.geometry,
            relationship.feature: relationship.geometry
        ]

        // Then
        XCTAssertEqual(geometryByFeature[.unit], .polygon)
        XCTAssertEqual(geometryByFeature[.opening], .line)
        XCTAssertEqual(geometryByFeature[.amenity], .point)
        XCTAssertEqual(geometryByFeature[.occupant], .form)
        XCTAssertEqual(geometryByFeature[.relationship], .form)
        XCTAssertEqual(unit.categoryFeature, .unit)
        XCTAssertEqual(opening.categoryFeature, .opening)
        XCTAssertEqual(amenity.categoryFeature, .amenity)
        XCTAssertEqual(occupant.categoryFeature, .occupant)
        XCTAssertEqual(relationship.categoryFeature, .relationship)
    }

    func test_whenFeatureRequiresReferences_thenContractExposesRequiredReferences() {
        // Given
        let footprint = IMDFAuthoringFeature.footprint.contract
        let unit = IMDFAuthoringFeature.unit.contract
        let anchor = IMDFAuthoringFeature.anchor.contract
        let geofence = IMDFAuthoringFeature.geofence.contract
        let relationship = IMDFAuthoringFeature.relationship.contract

        // When
        let referencesByFeature = [
            footprint.feature: footprint.requiredReferences,
            unit.feature: unit.requiredReferences,
            anchor.feature: anchor.requiredReferences,
            geofence.feature: geofence.requiredReferences,
            relationship.feature: relationship.requiredReferences
        ]

        // Then
        XCTAssertEqual(referencesByFeature[.footprint], [.building])
        XCTAssertEqual(referencesByFeature[.unit], [.level])
        XCTAssertEqual(referencesByFeature[.anchor], [.unit])
        XCTAssertEqual(referencesByFeature[.geofence], [.levelOrBuilding])
        XCTAssertEqual(referencesByFeature[.relationship], [.relationshipEndpoints])
    }

    func test_whenPolygonFeatureHasTooFewPoints_thenStateCannotFinish() {
        // Given
        let sut = makeSUT(selectedFeature: .unit)
        sut.setCategorySelected(true)
        sut.satisfyReference(.level)

        // When
        sut.addDraftPoint()
        sut.addDraftPoint()

        // Then
        XCTAssertFalse(sut.canFinish)
    }

    func test_whenPolygonFeatureHasRequiredCategoryReferenceAndPoints_thenStateCanFinish() {
        // Given
        let sut = makeSUT(selectedFeature: .unit)

        // When
        sut.setCategorySelected(true)
        sut.satisfyReference(.level)
        sut.addDraftPoint()
        sut.addDraftPoint()
        sut.addDraftPoint()

        // Then
        XCTAssertTrue(sut.canFinish)
    }

    func test_whenFormFeatureHasRequiredCategoryAndReference_thenStateCanFinishWithoutPoints() {
        // Given
        let sut = makeSUT(selectedFeature: .occupant)

        // When
        sut.setCategorySelected(true)
        sut.satisfyReference(.anchor)

        // Then
        XCTAssertTrue(sut.canFinish)
        XCTAssertEqual(sut.draftedPointCount, 0)
    }

    func test_whenFeatureSelectionChanges_thenDraftStateIsReset() {
        // Given
        let sut = makeSUT(selectedFeature: .unit)
        sut.setCategorySelected(true)
        sut.satisfyReference(.level)
        sut.addDraftPoint()
        sut.addDraftPoint()

        // When
        sut.selectFeature(.amenity)

        // Then
        XCTAssertEqual(sut.selectedFeature, .amenity)
        XCTAssertEqual(sut.draftedPointCount, 0)
        XCTAssertFalse(sut.hasSelectedCategory)
        XCTAssertTrue(sut.satisfiedReferences.isEmpty)
    }

    func test_whenDraftIsCancelled_thenSelectionIsKeptAndDraftStateIsReset() {
        // Given
        let sut = makeSUT(selectedFeature: .opening)
        sut.setCategorySelected(true)
        sut.satisfyReference(.level)
        sut.addDraftPoint()

        // When
        sut.cancel()

        // Then
        XCTAssertEqual(sut.selectedFeature, .opening)
        XCTAssertEqual(sut.draftedPointCount, 0)
        XCTAssertFalse(sut.hasSelectedCategory)
        XCTAssertTrue(sut.satisfiedReferences.isEmpty)
    }

    private func makeSUT(selectedFeature: IMDFAuthoringFeature = .unit) -> FeatureAuthoringToolState {
        FeatureAuthoringToolState(selectedFeature: selectedFeature)
    }
}
