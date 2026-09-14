import XCTest
@testable import Presentation

@MainActor
final class MapEditorTextTests: XCTestCase {
    func test_whenFeatureTitlesAreResolved_thenEveryAuthoringFeatureHasVisibleCopy() {
        // Given
        let features = IMDFAuthoringFeature.allCases

        // When
        let titles = features.map(\.title)
        let unresolvedTitles = titles.filter {
            $0.isEmpty || $0.hasPrefix("mapEditor.")
        }

        // Then
        XCTAssertEqual(titles.count, features.count)
        XCTAssertTrue(unresolvedTitles.isEmpty)
    }

    func test_whenDraftProgressIsFormatted_thenCurrentAndRequiredCountsRemainLegible() {
        // Given
        let currentPointCount = 2
        let requiredPointCount = 3

        // When
        let progress = MapEditorText.draftProgress(
            current: currentPointCount,
            required: requiredPointCount
        )

        // Then
        XCTAssertEqual(progress, "2/3")
    }
}
