import XCTest
@testable import Presentation

@MainActor
final class MapEditorViewModelTests: XCTestCase {
    func test_whenViewModelIsCreated_thenItExposesDefaultUnitDisplayState() {
        // Given
        let sut = makeSUT()

        // When
        let selectedFeature = sut.selectedFeatureDescriptor
        let geometry = sut.geometryDescriptor

        // Then
        XCTAssertEqual(selectedFeature.feature, .unit)
        XCTAssertEqual(selectedFeature.title, "Unit")
        XCTAssertEqual(selectedFeature.systemImage, "square.split.2x2")
        XCTAssertEqual(geometry.geometry, .polygon)
        XCTAssertEqual(geometry.title, "Polygon")
    }

    func test_whenFeatureIsSelected_thenViewModelUpdatesDisplayStateAndDraftProgress() {
        // Given
        let sut = makeSUT()

        // When
        sut.selectFeature(.opening)

        // Then
        XCTAssertEqual(sut.selectedFeature, .opening)
        XCTAssertEqual(sut.selectedFeatureDescriptor.title, "Opening")
        XCTAssertEqual(sut.geometryDescriptor.geometry, .line)
        XCTAssertEqual(sut.draftProgressText, "0/2")
    }

    func test_whenCategorySelectionIsToggled_thenCategoryRequirementBecomesReady() throws {
        // Given
        let sut = makeSUT()
        sut.selectFeature(.amenity)

        // When
        sut.toggleCategorySelection()

        // Then
        let categoryRequirement = try XCTUnwrap(sut.categoryRequirement)
        XCTAssertEqual(categoryRequirement.title, "Category")
        XCTAssertEqual(categoryRequirement.value, "Selected")
        XCTAssertTrue(categoryRequirement.isReady)
    }

    func test_whenReferencesAreRequiredAndSatisfied_thenReferenceRequirementBecomesReady() {
        // Given
        let sut = makeSUT()
        sut.selectFeature(.relationship)

        // When
        sut.satisfyRequiredReferences()

        // Then
        XCTAssertEqual(sut.referenceRequirement.title, "References")
        XCTAssertEqual(sut.referenceRequirement.value, "Linked")
        XCTAssertTrue(sut.referenceRequirement.isReady)
    }

    func test_whenDraftPointIsAdded_thenDraftProgressAndRemoveAvailabilityUpdate() {
        // Given
        let sut = makeSUT()

        // When
        sut.addDraftPoint()

        // Then
        XCTAssertEqual(sut.draftProgressText, "1/3")
        XCTAssertTrue(sut.canRemoveDraftPoint)
    }

    func test_whenFormFeatureIsSelected_thenDraftPointCannotBeAdded() {
        // Given
        let sut = makeSUT()

        // When
        sut.selectFeature(.building)

        // Then
        XCTAssertFalse(sut.canAddDraftPoint)
        XCTAssertEqual(sut.draftProgressText, "0/0")
    }

    func test_whenDraftCanFinish_thenFinishDraftReturnsResult() throws {
        // Given
        let sut = makeSUT()
        sut.toggleCategorySelection()
        sut.satisfyRequiredReferences()
        sut.addDraftPoint()
        sut.addDraftPoint()
        sut.addDraftPoint()

        // When
        let result = try XCTUnwrap(sut.finishDraft())

        // Then
        XCTAssertEqual(result.geometry, .polygon)
        XCTAssertEqual(result.coordinates.count, 3)
    }

    func test_whenDraftIsCancelled_thenDisplayStateResetsForSelectedFeature() {
        // Given
        let sut = makeSUT()
        sut.toggleCategorySelection()
        sut.satisfyRequiredReferences()
        sut.addDraftPoint()

        // When
        sut.cancelDraft()

        // Then
        XCTAssertEqual(sut.selectedFeature, .unit)
        XCTAssertEqual(sut.draftProgressText, "0/3")
        XCTAssertFalse(sut.canRemoveDraftPoint)
        XCTAssertFalse(sut.canFinishDraft)
    }

    private func makeSUT() -> MapEditorViewModel {
        MapEditorViewModel()
    }
}
