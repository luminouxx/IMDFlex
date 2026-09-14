import SwiftUI

public struct IMDFButtonStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var systemReduceMotion
    @Environment(\.imdfMotionMode) private var motionMode
    @Environment(\.isEnabled) private var isEnabled

    private let role: IMDFButtonRole

    public init(_ role: IMDFButtonRole) {
        self.role = role
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(IMDFFont.controlLabel)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.horizontal, IMDFSpacing.lg)
            .frame(minHeight: IMDFControlMetrics.minimumHitSize)
            .foregroundStyle(foregroundStyle)
            .background(backgroundStyle(configuration: configuration))
            .overlay {
                RoundedRectangle(cornerRadius: IMDFRadius.control)
                    .stroke(borderStyle, lineWidth: role == .secondary ? 1 : 0)
            }
            .clipShape(.rect(cornerRadius: IMDFRadius.control))
            .contentShape(.rect)
            .scaleEffect(pressedScale(configuration: configuration))
            .opacity(opacity(configuration: configuration))
            .animation(pressAnimation, value: configuration.isPressed)
    }

    private var foregroundStyle: Color {
        switch role {
        case .primary, .destructive: .white
        case .secondary: .primary
        }
    }

    private func backgroundStyle(configuration: Configuration) -> Color {
        switch role {
        case .primary:
            configuration.isPressed ? IMDFColor.accentFillPressed : IMDFColor.accentFill
        case .secondary:
            configuration.isPressed ? Color.primary.opacity(0.10) : IMDFColor.neutralFill
        case .destructive:
            configuration.isPressed ? IMDFColor.dangerFillPressed : IMDFColor.dangerFill
        }
    }

    private var borderStyle: Color {
        role == .secondary ? IMDFColor.separator : .clear
    }

    private func pressedScale(configuration: Configuration) -> CGFloat {
        guard motionMode.allowsSpatialMotion(systemReduceMotion: systemReduceMotion) else {
            return 1
        }

        return configuration.isPressed ? 0.98 : 1
    }

    private func opacity(configuration: Configuration) -> Double {
        guard isEnabled else { return 0.38 }
        return configuration.isPressed ? 0.88 : 1
    }

    private var pressAnimation: Animation? {
        guard motionMode.allowsSpatialMotion(systemReduceMotion: systemReduceMotion) else {
            return nil
        }

        return .easeOut(duration: 0.12)
    }
}

public extension ButtonStyle where Self == IMDFButtonStyle {
    static var imdfPrimary: IMDFButtonStyle { IMDFButtonStyle(.primary) }
    static var imdfSecondary: IMDFButtonStyle { IMDFButtonStyle(.secondary) }
    static var imdfDestructive: IMDFButtonStyle { IMDFButtonStyle(.destructive) }
}

#Preview("Button Styles") {
    VStack(spacing: IMDFSpacing.lg) {
        Button("Create feature", systemImage: "plus") {}
            .buttonStyle(.imdfPrimary)

        Button("Review issues", systemImage: "exclamationmark.triangle") {}
            .buttonStyle(.imdfSecondary)

        Button("Delete feature", systemImage: "trash", role: .destructive) {}
            .buttonStyle(.imdfDestructive)

        Button("Export IMDF", systemImage: "square.and.arrow.up") {}
            .buttonStyle(.imdfPrimary)
            .disabled(true)
    }
    .padding()
}
