import SwiftUI
import DesignSystem

struct CreateProjectSheet: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var projectName: String

    let canCreateProject: Bool
    let isCreatingProject: Bool
    let alert: ProjectHomeAlert?
    let onCreateProject: () async -> Bool

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: IMDFSpacing.xl) {
                IMDFField(ProjectHomeText.projectName, text: $projectName)
                    .placeholder(ProjectHomeText.projectNamePlaceholder)
                    .supportingText(ProjectHomeText.projectNameSupporting)
                    .error(fieldErrorMessage)
                    .systemImage(ProjectHomeSymbol.project)

                if isCreatingProject {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel(ProjectHomeText.newProject)
                }

                Spacer(minLength: IMDFSpacing.lg)
            }
            .padding(IMDFSpacing.xl)
            .navigationTitle(ProjectHomeText.createTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(ProjectHomeText.cancel, action: dismiss.callAsFunction)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(
                        ProjectHomeText.newProject,
                        systemImage: ProjectHomeSymbol.add,
                        action: submit
                    )
                    .disabled(!canCreateProject)
                }
            }
        }
        .presentationDetents([.medium])
        .interactiveDismissDisabled(isCreatingProject)
    }

    private var fieldErrorMessage: String? {
        switch alert {
        case .invalidProjectName:
            ProjectHomeText.invalidProjectName
        case .creationFailed:
            ProjectHomeText.creationFailed
        case .loadingFailed, .deletionFailed, nil:
            nil
        }
    }

    private func submit() {
        Task {
            if await onCreateProject() {
                dismiss()
            }
        }
    }
}
