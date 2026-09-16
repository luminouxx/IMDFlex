import SwiftUI
import DesignSystem

struct ProjectHomeSectionHeading: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: IMDFSpacing.xs) {
            Text(title)
                .font(.title2)
                .bold()

            Text(subtitle)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
