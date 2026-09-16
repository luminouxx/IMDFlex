import SwiftUI
import DesignSystem

struct ProjectWorkflowStepView: View {
    let step: ProjectHomeWorkflowStep

    var body: some View {
        VStack(alignment: .leading, spacing: IMDFSpacing.md) {
            Image(systemName: step.systemImage)
                .font(.headline)
                .foregroundStyle(IMDFColor.accent)
                .frame(width: 40, height: 40)
                .background(IMDFColor.selectedFill)
                .clipShape(.rect(cornerRadius: IMDFRadius.control))
                .accessibilityHidden(true)

            Text(step.title)
                .font(.headline)

            Text(step.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .topLeading)
        .padding(IMDFSpacing.lg)
        .background(IMDFColor.neutralFill)
        .overlay {
            RoundedRectangle(cornerRadius: IMDFRadius.panel)
                .stroke(IMDFColor.separator, lineWidth: 1)
        }
        .clipShape(.rect(cornerRadius: IMDFRadius.panel))
        .accessibilityElement(children: .combine)
    }
}
