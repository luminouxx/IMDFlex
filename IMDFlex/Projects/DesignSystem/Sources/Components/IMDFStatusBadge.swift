import SwiftUI

public struct IMDFStatusBadge: View {
    private let title: String
    private var role: IMDFStatusBadgeRole = .info
    private var customSystemImage: String?

    public init(_ title: String) {
        self.title = title
    }

    public var body: some View {
        Label(title, systemImage: customSystemImage ?? role.systemImage)
            .font(IMDFFont.badge)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
            .labelStyle(.titleAndIcon)
            .padding(.horizontal, IMDFSpacing.md)
            .frame(minHeight: IMDFControlMetrics.statusHeight)
            .background(IMDFColor.neutralFill)
            .foregroundStyle(role.tint)
            .clipShape(.rect(cornerRadius: IMDFRadius.badge))
            .accessibilityElement(children: .combine)
            .accessibilityValue(role.accessibilityValue)
    }

    public func status(_ role: IMDFStatusBadgeRole) -> Self {
        var copy = self
        copy.role = role
        return copy
    }

    public func statusIcon(_ systemImage: String?) -> Self {
        var copy = self
        copy.customSystemImage = systemImage
        return copy
    }
}

#Preview("Status Badges") {
    VStack(alignment: .leading, spacing: IMDFSpacing.sm) {
        IMDFStatusBadge("Ready").status(.success)
        IMDFStatusBadge("3 Issues").status(.warning)
        IMDFStatusBadge("Invalid Geometry").status(.error)
        IMDFStatusBadge("Unit").status(.selected)
    }
    .padding()
}
