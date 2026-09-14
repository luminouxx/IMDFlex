import SwiftUI

public struct IMDFInspectorActionRow: View {
    private let title: String
    private let action: () -> Void
    private var value: String?
    private var systemImage: String?
    private var isComplete = false

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: IMDFSpacing.sm) {
                Image(
                    systemName: systemImage
                        ?? (isComplete ? DesignSystemSymbol.success : DesignSystemSymbol.incomplete)
                )
                    .font(.system(size: IMDFIconSize.small, weight: .semibold))
                    .foregroundStyle(isComplete ? IMDFColor.success : .secondary)
                    .accessibilityHidden(true)

                Text(title)
                    .font(IMDFFont.inspectorLabel)
                    .foregroundStyle(.secondary)

                Spacer(minLength: IMDFSpacing.md)

                if let value {
                    Text(value)
                        .font(IMDFFont.inspectorValue)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.trailing)
                }
            }
            .frame(minHeight: IMDFControlMetrics.minimumHitSize)
            .contentShape(.rect)
        }
        .buttonStyle(IMDFPressFeedbackStyle())
        .accessibilityElement(children: .combine)
        .accessibilityValue(isComplete ? DesignSystemText.complete : DesignSystemText.actionRequired)
    }

    public func value(_ value: String?) -> Self {
        var copy = self
        copy.value = value
        return copy
    }

    public func systemImage(_ systemImage: String?) -> Self {
        var copy = self
        copy.systemImage = systemImage
        return copy
    }

    public func complete(_ isComplete: Bool) -> Self {
        var copy = self
        copy.isComplete = isComplete
        return copy
    }
}

#Preview("Inspector Action Rows") {
    VStack(spacing: IMDFSpacing.sm) {
        IMDFInspectorActionRow("Category") {}
            .value("Required")

        IMDFInspectorActionRow("References") {}
            .value("Linked")
            .complete(true)
    }
    .padding()
}
