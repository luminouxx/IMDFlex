import SwiftUI
import DesignSystem

struct ProjectHomeEmptyState: View {
    let onCreateProject: () -> Void

    var body: some View {
        IMDFPanel {
            VStack(spacing: IMDFSpacing.lg) {
                EmptyStateView(
                    title: ProjectHomeText.noProjects,
                    message: ProjectHomeText.noProjectsMessage,
                    systemImage: ProjectHomeSymbol.project
                )

                Button(
                    ProjectHomeText.newProject,
                    systemImage: ProjectHomeSymbol.add,
                    action: onCreateProject
                )
                .buttonStyle(.imdfPrimary)
            }
            .frame(maxWidth: .infinity)
        }
        .imdfPanelStyle(.inspector)
    }
}
