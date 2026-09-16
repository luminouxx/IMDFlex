import SwiftUI
import Domain
import DesignSystem

struct ProjectHomeContent: View {
    @Environment(\.imdfLayoutMode) private var layoutMode

    let projects: [IMDFProject]
    let hasStoredProjects: Bool
    let loadState: ProjectHomeLoadState
    let alert: ProjectHomeAlert?
    let isFiltering: Bool
    let onCreateProject: () -> Void
    let onOpenProject: (UUID) -> Void
    let onDeleteProject: (UUID) async -> Void
    let onRetry: () async -> Void

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: IMDFSpacing.xxl) {
                ProjectHomeHeader(onCreateProject: onCreateProject)
                ProjectWorkflowOverview()
                ProjectHomeProjectsSection(
                    projects: projects,
                    hasStoredProjects: hasStoredProjects,
                    loadState: loadState,
                    alert: alert,
                    isFiltering: isFiltering,
                    onCreateProject: onCreateProject,
                    onOpenProject: onOpenProject,
                    onDeleteProject: onDeleteProject,
                    onRetry: onRetry
                )
            }
            .frame(maxWidth: 1_180, alignment: .leading)
            .padding(.horizontal, layoutMode.contentPadding)
            .padding(.top, IMDFSpacing.xl)
            .padding(.bottom, IMDFSpacing.xxxl)
            .frame(maxWidth: .infinity)
        }
        .background {
            ProjectHomeBackground()
        }
    }
}
