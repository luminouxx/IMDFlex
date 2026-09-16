import XCTest
import DesignSystem
@testable import Presentation

final class ProjectHomeLayoutResolverTests: XCTestCase {
    func test_whenWidthIsBelowCompactBoundary_thenCompactLayoutIsSelected() {
        // Given
        let width = 699.0

        // When
        let mode = ProjectHomeLayoutResolver.mode(for: width)

        // Then
        XCTAssertEqual(mode, .compact)
    }

    func test_whenWidthFitsIntermediateRange_thenIntermediateLayoutIsSelected() {
        // Given
        let width = 700.0

        // When
        let mode = ProjectHomeLayoutResolver.mode(for: width)

        // Then
        XCTAssertEqual(mode, .intermediate)
    }

    func test_whenWidthMeetsRegularBoundary_thenRegularLayoutIsSelected() {
        // Given
        let width = 1_050.0

        // When
        let mode = ProjectHomeLayoutResolver.mode(for: width)

        // Then
        XCTAssertEqual(mode, .regular)
    }
}
