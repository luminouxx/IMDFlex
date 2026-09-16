import SwiftUI
import DesignSystem

struct ProjectHomeErrorState: View {
    let onRetry: () async -> Void

    var body: some View {
        IMDFPanel {
            ContentUnavailableView {
                Label(ProjectHomeText.loadFailed, systemImage: ProjectHomeSymbol.error)
            } description: {
                Text(ProjectHomeText.loadFailedMessage)
            } actions: {
                Button(
                    ProjectHomeText.retry,
                    systemImage: ProjectHomeSymbol.retry,
                    action: retry
                )
                .buttonStyle(.imdfPrimary)
            }
        }
        .imdfPanelStyle(.inspector)
    }

    private func retry() {
        Task {
            await onRetry()
        }
    }
}
