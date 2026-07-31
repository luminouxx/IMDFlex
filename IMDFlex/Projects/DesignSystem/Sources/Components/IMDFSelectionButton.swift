import SwiftUI

public struct IMDFSelectionButton: View {
    private let title: String
    private let subtitle: String?
    private let systemImage: String?
    private let isSelected: Bool
    private let action: () -> Void

    public init(
        title: String,
        subtitle: String? = nil,
        systemImage: String? = nil,
        isSelected: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.isSelected = isSelected
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: IMDFSpacing.sm) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: IMDFIconSize.sm, weight: .semibold))
                        .frame(width: IMDFIconSize.lg, height: IMDFIconSize.lg)
                }

                VStack(alignment: .leading, spacing: IMDFSpacing.xxs) {
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .lineLimit(1)

                    if let subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(isSelected ? .white.opacity(0.82) : .secondary)
                            .lineLimit(1)
                    }
                }

                Spacer(minLength: IMDFSpacing.sm)

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: IMDFIconSize.sm, weight: .bold))
                }
            }
            .frame(minHeight: 44)
            .padding(.horizontal, IMDFSpacing.md)
            .padding(.vertical, IMDFSpacing.sm)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .background(isSelected ? IMDFColor.selection : Color.primary.opacity(0.06))
        .foregroundStyle(isSelected ? .white : .primary)
        .overlay {
            RoundedRectangle(cornerRadius: IMDFRadius.lg, style: .continuous)
                .stroke(isSelected ? IMDFColor.selection : IMDFColor.separator, lineWidth: 1)
        }
        .clipShape(.rect(cornerRadius: IMDFRadius.lg, style: .continuous))
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview("Selection Buttons") {
    VStack(spacing: IMDFSpacing.sm) {
        IMDFSelectionButton(
            title: "Unit",
            subtitle: "Polygon",
            systemImage: "square.split.2x2",
            isSelected: true
        ) {}

        IMDFSelectionButton(
            title: "Opening",
            subtitle: "Line",
            systemImage: "door.left.hand.open"
        ) {}
    }
    .padding()
}
