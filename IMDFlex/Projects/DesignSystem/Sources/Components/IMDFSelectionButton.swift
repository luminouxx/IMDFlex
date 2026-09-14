import SwiftUI

public struct IMDFSelectionButton: View {
    @Environment(\.isEnabled) private var isEnabled

    private let title: String
    private let action: () -> Void
    private var subtitle: String?
    private var systemImage: String?
    private var isSelected = false

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: IMDFSpacing.sm) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: IMDFIconSize.small, weight: .semibold))
                        .frame(width: IMDFIconSize.large, height: IMDFIconSize.large)
                        .accessibilityHidden(true)
                }

                VStack(alignment: .leading, spacing: IMDFSpacing.xxs) {
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .lineLimit(2)

                    if let subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                }

                Spacer(minLength: IMDFSpacing.sm)

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: IMDFIconSize.small, weight: .bold))
                        .accessibilityHidden(true)
                }
            }
            .frame(minHeight: 44)
            .padding(.horizontal, IMDFSpacing.md)
            .frame(minHeight: IMDFControlMetrics.minimumHitSize)
            .contentShape(.rect)
        }
        .buttonStyle(IMDFPressFeedbackStyle())
        .background(isSelected ? IMDFColor.selectedFill : IMDFColor.neutralFill)
        .foregroundStyle(.primary)
        .overlay {
            RoundedRectangle(cornerRadius: IMDFRadius.control)
                .stroke(isSelected ? IMDFColor.selection : IMDFColor.separator, lineWidth: isSelected ? 2 : 1)
        }
        .clipShape(.rect(cornerRadius: IMDFRadius.control))
        .opacity(isEnabled ? 1 : 0.38)
        .accessibilityElement(children: .combine)
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    public func subtitle(_ subtitle: String?) -> Self {
        var copy = self
        copy.subtitle = subtitle
        return copy
    }

    public func systemImage(_ systemImage: String?) -> Self {
        var copy = self
        copy.systemImage = systemImage
        return copy
    }

    public func selected(_ isSelected: Bool) -> Self {
        var copy = self
        copy.isSelected = isSelected
        return copy
    }
}

#Preview("Selection Buttons") {
    VStack(spacing: IMDFSpacing.sm) {
        IMDFSelectionButton("Unit") {}
            .subtitle("Polygon")
            .systemImage("square.split.2x2")
            .selected(true)

        IMDFSelectionButton("Opening") {}
            .subtitle("Line")
            .systemImage("door.left.hand.open")
    }
    .padding()
}
