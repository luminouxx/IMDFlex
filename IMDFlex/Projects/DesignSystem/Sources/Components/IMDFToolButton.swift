import SwiftUI

public struct IMDFToolButton: View {
    @Environment(\.accessibilityReduceMotion) private var systemReduceMotion
    @Environment(\.imdfMotionMode) private var motionMode
    @Environment(\.isEnabled) private var isEnabled

    private let title: String
    private let systemImage: String
    private let action: () -> Void
    private var isSelected = false
    private var role: IMDFButtonRole = .secondary

    public init(
        _ title: String,
        systemImage: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }

    public var body: some View {
        Button(
            title,
            systemImage: systemImage,
            role: role == .destructive ? .destructive : nil,
            action: action
        )
            .labelStyle(.iconOnly)
            .font(.system(size: IMDFIconSize.regular, weight: .semibold))
            .frame(
                minWidth: IMDFControlMetrics.minimumHitSize,
                minHeight: IMDFControlMetrics.minimumHitSize
            )
            .buttonStyle(IMDFPressFeedbackStyle())
            .background(backgroundStyle)
            .foregroundStyle(foregroundStyle)
            .overlay {
                RoundedRectangle(cornerRadius: IMDFRadius.control)
                    .stroke(borderStyle, lineWidth: isSelected ? 2 : 1)
            }
            .clipShape(.rect(cornerRadius: IMDFRadius.control))
            .contentShape(.rect)
            .opacity(isEnabled ? 1 : 0.38)
            .animation(motionAnimation, value: isSelected)
            .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    public func selected(_ isSelected: Bool) -> Self {
        var copy = self
        copy.isSelected = isSelected
        return copy
    }

    public func role(_ role: IMDFButtonRole) -> Self {
        var copy = self
        copy.role = role
        return copy
    }

    private var backgroundStyle: Color {
        if isSelected {
            return role == .destructive ? IMDFColor.dangerFill : IMDFColor.accentFill
        }

        return IMDFColor.neutralFill
    }

    private var foregroundStyle: Color {
        if isSelected {
            return .white
        }

        switch role {
        case .primary: return IMDFColor.accent
        case .secondary: return .primary
        case .destructive: return IMDFColor.danger
        }
    }

    private var borderStyle: Color {
        if isSelected {
            return role == .destructive ? IMDFColor.danger : IMDFColor.accent
        }

        return IMDFColor.separator
    }

    private var motionAnimation: Animation? {
        motionMode.allowsSpatialMotion(systemReduceMotion: systemReduceMotion)
            ? .easeOut(duration: 0.12)
            : nil
    }
}

#Preview("Tool Buttons") {
    IMDFPanel {
        HStack(spacing: IMDFSpacing.sm) {
            IMDFToolButton("Select", systemImage: "cursorarrow") {}
                .selected(true)
            IMDFToolButton("Draw", systemImage: "pencil") {}
            IMDFToolButton("Delete", systemImage: "trash") {}
                .role(.destructive)
        }
    }
    .padding()
}
