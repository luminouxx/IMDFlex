import SwiftUI

public enum IMDFControlRole: Sendable {
    case normal
    case primary
    case destructive
}

public struct IMDFToolButton: View {
    private let title: String
    private let systemImage: String
    private let isSelected: Bool
    private let role: IMDFControlRole
    private let action: () -> Void

    public init(
        title: String,
        systemImage: String,
        isSelected: Bool = false,
        role: IMDFControlRole = .normal,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.isSelected = isSelected
        self.role = role
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: IMDFIconSize.md, weight: .semibold))
                .frame(width: 44, height: 44)
                .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .background(backgroundColor)
        .foregroundStyle(foregroundColor)
        .overlay {
            RoundedRectangle(cornerRadius: IMDFRadius.lg, style: .continuous)
                .stroke(borderColor, lineWidth: isSelected ? 1.5 : 1)
        }
        .clipShape(.rect(cornerRadius: IMDFRadius.lg, style: .continuous))
        .accessibilityLabel(title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private var backgroundColor: Color {
        if isSelected {
            return selectedColor
        }

        return Color.primary.opacity(0.06)
    }

    private var foregroundColor: Color {
        if isSelected {
            return .white
        }

        switch role {
        case .normal: return .primary
        case .primary: return IMDFColor.accent
        case .destructive: return IMDFColor.danger
        }
    }

    private var borderColor: Color {
        if isSelected {
            return selectedColor
        }

        return IMDFColor.separator
    }

    private var selectedColor: Color {
        switch role {
        case .normal, .primary: return IMDFColor.selection
        case .destructive: return IMDFColor.danger
        }
    }
}

public struct IMDFButtonStyle: ButtonStyle {
    private let role: IMDFControlRole

    public init(role: IMDFControlRole = .primary) {
        self.role = role
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.semibold))
            .padding(.horizontal, IMDFSpacing.lg)
            .padding(.vertical, IMDFSpacing.md)
            .background(backgroundColor.opacity(configuration.isPressed ? 0.82 : 1))
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: IMDFRadius.lg, style: .continuous))
    }

    private var backgroundColor: Color {
        switch role {
        case .normal, .primary: return IMDFColor.accent
        case .destructive: return IMDFColor.danger
        }
    }
}

public extension ButtonStyle where Self == IMDFButtonStyle {
    static var imdf: IMDFButtonStyle { IMDFButtonStyle() }

    static func imdf(role: IMDFControlRole) -> IMDFButtonStyle {
        IMDFButtonStyle(role: role)
    }
}

#Preview("Tool Buttons") {
    IMDFPanel {
        HStack(spacing: IMDFSpacing.sm) {
            IMDFToolButton(title: "Select", systemImage: "cursorarrow", isSelected: true) {}
            IMDFToolButton(title: "Draw", systemImage: "pencil") {}
            IMDFToolButton(title: "Delete", systemImage: "trash", role: .destructive) {}
        }
    }
    .padding()
}
