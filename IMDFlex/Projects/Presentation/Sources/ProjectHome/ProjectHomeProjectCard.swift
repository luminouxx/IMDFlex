import SwiftUI
import DesignSystem

struct ProjectHomeProjectCard: View {
    @State private var isConfirmingDeletion = false

    let name: String
    let updatedAt: Date
    let onOpen: () -> Void
    let onDelete: () async -> Void

    var body: some View {
        IMDFPanel {
            HStack(spacing: IMDFSpacing.md) {
                Button(action: onOpen) {
                    HStack(spacing: IMDFSpacing.md) {
                        Image(systemName: ProjectHomeSymbol.project)
                            .font(.title3)
                            .foregroundStyle(IMDFColor.accent)
                            .frame(width: 48, height: 48)
                            .background(IMDFColor.selectedFill)
                            .clipShape(.rect(cornerRadius: IMDFRadius.control))
                            .accessibilityHidden(true)

                        VStack(alignment: .leading, spacing: IMDFSpacing.sm) {
                            Text(name)
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)

                            Label {
                                Text(updatedAt, style: .relative)
                            } icon: {
                                Image(systemName: ProjectHomeSymbol.updated)
                            }
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .accessibilityLabel(ProjectHomeText.lastUpdated)
                            .accessibilityValue(Text(updatedAt, style: .relative))
                        }

                        Spacer(minLength: IMDFSpacing.sm)
                    }
                    .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
                    .contentShape(.rect)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(ProjectHomeText.openProject)
                .accessibilityValue(name)

                Menu(ProjectHomeText.projectActions, systemImage: ProjectHomeSymbol.actions) {
                    Button(
                        ProjectHomeText.openProject,
                        systemImage: ProjectHomeSymbol.open,
                        action: onOpen
                    )

                    Button(
                        ProjectHomeText.deleteProject,
                        systemImage: ProjectHomeSymbol.delete,
                        role: .destructive,
                        action: requestDeletion
                    )
                }
                .labelStyle(.iconOnly)
                .frame(minWidth: 44, minHeight: 44)
                .confirmationDialog(
                    ProjectHomeText.deleteConfirmationTitle,
                    isPresented: $isConfirmingDeletion,
                    titleVisibility: .visible
                ) {
                    Button(
                        ProjectHomeText.deleteProject,
                        role: .destructive,
                        action: confirmDeletion
                    )

                    Button(ProjectHomeText.cancel, role: .cancel) {}
                } message: {
                    Text(ProjectHomeText.deleteConfirmationMessage)
                }
            }
        }
        .imdfPanelStyle(.inspector)
    }

    private func requestDeletion() {
        isConfirmingDeletion = true
    }

    private func confirmDeletion() {
        Task {
            await onDelete()
        }
    }
}
