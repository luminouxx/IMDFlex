import SwiftUI
import DesignSystem

struct ProjectHomeInlineNotice: View {
    let message: String

    var body: some View {
        Label(message, systemImage: ProjectHomeSymbol.error)
            .font(.subheadline)
            .foregroundStyle(IMDFColor.danger)
            .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
            .padding(.horizontal, IMDFSpacing.lg)
            .background(IMDFColor.danger.opacity(0.10))
            .clipShape(.rect(cornerRadius: IMDFRadius.control))
            .accessibilityElement(children: .combine)
    }
}
