import SwiftUI
import Domain
import DesignSystem

struct ProjectHomeProjectsSection: View {
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
        let minimumCardWidth = layoutMode == .compact ? 280.0 : 340.0
        let columns = [
            GridItem(
                .adaptive(minimum: minimumCardWidth, maximum: 560),
                spacing: IMDFSpacing.lg,
                alignment: .top
            )
        ]

        VStack(alignment: .leading, spacing: IMDFSpacing.lg) {
            ProjectHomeSectionHeading(
                title: ProjectHomeText.recentProjects,
                subtitle: ProjectHomeText.recentProjectsSubtitle
            )

            if alert == .deletionFailed {
                ProjectHomeInlineNotice(message: ProjectHomeText.deletionFailed)
            }

            switch loadState {
            case .idle, .loading:
                ProjectHomeLoadingState()
            case .failed:
                ProjectHomeErrorState(onRetry: onRetry)
            case .loaded:
                if !hasStoredProjects {
                    ProjectHomeEmptyState(onCreateProject: onCreateProject)
                } else if projects.isEmpty && isFiltering {
                    ProjectHomeSearchEmptyState()
                } else {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: IMDFSpacing.lg) {
                        ForEach(projects) { project in
                            ProjectHomeProjectCard(
                                name: project.name,
                                updatedAt: project.updatedAt,
                                onOpen: {
                                    onOpenProject(project.id)
                                },
                                onDelete: {
                                    await onDeleteProject(project.id)
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}
