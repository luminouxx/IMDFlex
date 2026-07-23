import SwiftUI

public enum IMDFStatusBadgeRole: Sendable {
    case info
    case success
    case warning
    case error
    case selected
}

public struct IMDFStatusBadge: View {
    private let title: String
    private let systemImage: String?
    private let role: IMDFStatusBadgeRole

    public init(
        _ title: String,
        systemImage: String? = nil,
        role: IMDFStatusBadgeRole = .info
    ) {
        self.title = title
        self.systemImage = systemImage
        self.role = role
    }

    public var body: some View {
        Label {
            Text(title)
                .font(IMDFFont.badge)
                .lineLimit(1)
        } icon: {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: IMDFIconSize.sm, weight: .semibold))
            }
        }
        .labelStyle(.titleAndIcon)
        .padding(.horizontal, IMDFSpacing.sm)
        .padding(.vertical, IMDFSpacing.xs)
        .background(tint.opacity(0.14))
        .foregroundStyle(tint)
        .clipShape(.rect(cornerRadius: IMDFRadius.md, style: .continuous))
        .accessibilityElement(children: .combine)
    }

    private var tint: Color {
        switch role {
        case .info: return IMDFColor.accent
        case .success: return IMDFColor.success
        case .warning: return IMDFColor.warning
        case .error: return IMDFColor.danger
        case .selected: return IMDFColor.selection
        }
    }
}

#Preview("Status Badges") {
    VStack(alignment: .leading, spacing: IMDFSpacing.sm) {
        IMDFStatusBadge("Ready", systemImage: "checkmark.circle", role: .success)
        IMDFStatusBadge("3 Issues", systemImage: "exclamationmark.triangle", role: .warning)
        IMDFStatusBadge("Invalid Geometry", systemImage: "xmark.octagon", role: .error)
        IMDFStatusBadge("Unit", systemImage: "square.split.2x2", role: .selected)
    }
    .padding()
}
