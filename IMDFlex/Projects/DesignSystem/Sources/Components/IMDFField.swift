import SwiftUI

public struct IMDFField: View {
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var text: String
    @FocusState private var isFocused: Bool

    private let title: String
    private var placeholder = ""
    private var supportingText: String?
    private var errorMessage: String?
    private var systemImage: String?
    private var isReadOnly = false

    public init(_ title: String, text: Binding<String>) {
        self.title = title
        _text = text
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: IMDFSpacing.sm) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .accessibilityHidden(true)

            HStack(spacing: IMDFSpacing.sm) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                }

                if isReadOnly {
                    Text(readOnlyDisplayText)
                        .foregroundStyle(text.isEmpty ? .secondary : .primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel(title)
                        .accessibilityValue(readOnlyDisplayText)
                        .accessibilityHint("Read only")

                    Image(systemName: "lock.fill")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                } else {
                    TextField(placeholder, text: $text)
                        .focused($isFocused)
                        .accessibilityLabel(title)
                        .accessibilityHint(errorMessage ?? supportingText ?? "")
                }
            }
            .padding(.horizontal, IMDFSpacing.lg)
            .frame(minHeight: IMDFControlMetrics.fieldHeight)
            .background(fieldBackground)
            .overlay {
                RoundedRectangle(cornerRadius: IMDFRadius.control)
                    .stroke(borderColor, lineWidth: hasEmphasizedBorder ? 2 : 1)
            }
            .clipShape(.rect(cornerRadius: IMDFRadius.control))
            .opacity(isEnabled ? 1 : 0.38)

            if let errorMessage {
                Label(errorMessage, systemImage: "exclamationmark.circle.fill")
                    .font(IMDFFont.supporting)
                    .foregroundStyle(IMDFColor.danger)
            } else if let supportingText {
                Text(supportingText)
                    .font(IMDFFont.supporting)
                    .foregroundStyle(.secondary)
            }
        }
    }

    public func placeholder(_ placeholder: String) -> Self {
        var copy = self
        copy.placeholder = placeholder
        return copy
    }

    public func supportingText(_ supportingText: String?) -> Self {
        var copy = self
        copy.supportingText = supportingText
        return copy
    }

    public func error(_ errorMessage: String?) -> Self {
        var copy = self
        copy.errorMessage = errorMessage
        return copy
    }

    public func systemImage(_ systemImage: String?) -> Self {
        var copy = self
        copy.systemImage = systemImage
        return copy
    }

    public func readOnly(_ isReadOnly: Bool = true) -> Self {
        var copy = self
        copy.isReadOnly = isReadOnly
        return copy
    }

    private var fieldBackground: Color {
        isReadOnly ? Color.primary.opacity(0.035) : IMDFColor.neutralFill
    }

    private var readOnlyDisplayText: String {
        text.isEmpty ? placeholder : text
    }

    private var hasEmphasizedBorder: Bool {
        errorMessage != nil || (isFocused && isEnabled && !isReadOnly)
    }

    private var borderColor: Color {
        if errorMessage != nil {
            return IMDFColor.danger
        }

        return hasEmphasizedBorder ? IMDFColor.accent : IMDFColor.separator
    }
}

#Preview("Fields") {
    @Previewable @State var name = "Main Hall"

    VStack(spacing: IMDFSpacing.xl) {
        IMDFField("Name", text: $name)
            .placeholder("Feature name")
            .supportingText("Shown to map users")

        IMDFField("Category", text: .constant("conference_room"))
            .error("Choose a valid Apple IMDF category")

        IMDFField("Level reference", text: .constant("level_id · 01C8"))
            .readOnly()
    }
    .padding()
}
