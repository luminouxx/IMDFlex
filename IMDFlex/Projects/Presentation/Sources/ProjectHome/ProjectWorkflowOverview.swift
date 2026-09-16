import SwiftUI
import DesignSystem

struct ProjectWorkflowOverview: View {
    @Environment(\.imdfLayoutMode) private var layoutMode
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        VStack(alignment: .leading, spacing: IMDFSpacing.lg) {
            ProjectHomeSectionHeading(
                title: ProjectHomeText.workflow,
                subtitle: ProjectHomeText.workflowSubtitle
            )

            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: IMDFSpacing.md),
                    count: dynamicTypeSize.isAccessibilitySize
                        ? 1
                        : layoutMode.workflowColumnCount
                ),
                alignment: .leading,
                spacing: IMDFSpacing.md
            ) {
                ForEach(ProjectHomeWorkflowStep.allCases) { step in
                    ProjectWorkflowStepView(step: step)
                }
            }
        }
    }
}

private extension IMDFLayoutMode {
    var workflowColumnCount: Int {
        switch self {
        case .compact:
            1
        case .intermediate:
            2
        case .regular:
            4
        }
    }
}
