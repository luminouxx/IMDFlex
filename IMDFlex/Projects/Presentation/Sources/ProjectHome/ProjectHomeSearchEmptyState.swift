import SwiftUI
import DesignSystem

struct ProjectHomeSearchEmptyState: View {
    var body: some View {
        IMDFPanel {
            ContentUnavailableView.search
                .frame(maxWidth: .infinity, minHeight: 180)
        }
        .imdfPanelStyle(.inspector)
    }
}
