import XCTest
@testable import Presentation

@MainActor
final class ProjectHomeTextTests: XCTestCase {
    func test_whenProjectHomeCopyIsResolved_thenShippingLabelsAreVisible() {
        // Given
        let labels = [
            ProjectHomeText.navigationTitle,
            ProjectHomeText.heroTitle,
            ProjectHomeText.newProject,
            ProjectHomeText.recentProjects,
            ProjectHomeText.createTitle,
            ProjectHomeText.deleteProject
        ]

        // When
        let unresolvedLabels = labels.filter {
            $0.isEmpty || $0.hasPrefix("projectHome.")
        }

        // Then
        XCTAssertTrue(unresolvedLabels.isEmpty)
    }
}
