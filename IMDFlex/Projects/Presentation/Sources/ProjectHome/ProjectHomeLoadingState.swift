import SwiftUI
import DesignSystem

struct ProjectHomeLoadingState: View {
    var body: some View {
        IMDFPanel {
            ProgressView()
                .controlSize(.large)
                .frame(maxWidth: .infinity, minHeight: 180)
                .accessibilityLabel(ProjectHomeText.recentProjects)
        }
        .imdfPanelStyle(.inspector)
    }
}
