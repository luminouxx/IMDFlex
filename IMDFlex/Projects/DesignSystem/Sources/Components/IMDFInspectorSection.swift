import SwiftUI

public struct IMDFInspectorSection<Content: View>: View {
    private let title: String
    private let content: Content

    public init(
        title: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: IMDFSpacing.md) {
            Text(title)
                .font(IMDFFont.panelTitle)
                .foregroundStyle(.primary)

            VStack(spacing: IMDFSpacing.sm) {
                content
            }
        }
    }
}

public struct IMDFInspectorRow<Trailing: View>: View {
    private let title: String
    private let systemImage: String?
    private let trailing: Trailing

    public init(
        title: String,
        systemImage: String? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.systemImage = systemImage
        self.trailing = trailing()
    }

    public var body: some View {
        HStack(spacing: IMDFSpacing.sm) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: IMDFIconSize.sm, weight: .semibold))
                    .frame(width: IMDFIconSize.md, height: IMDFIconSize.md)
                    .foregroundStyle(.secondary)
            }

            Text(title)
                .font(IMDFFont.inspectorLabel)
                .foregroundStyle(.secondary)

            Spacer(minLength: IMDFSpacing.md)

            trailing
                .font(IMDFFont.inspectorValue)
        }
        .frame(minHeight: 32)
        .accessibilityElement(children: .combine)
    }
}

public extension IMDFInspectorRow where Trailing == Text {
    init(
        title: String,
        value: String,
        systemImage: String? = nil
    ) {
        self.init(title: title, systemImage: systemImage) {
            Text(value)
        }
    }
}

#Preview("Inspector Section") {
    IMDFPanel(role: .inspector) {
        IMDFInspectorSection(title: "Authoring") {
            IMDFInspectorRow(title: "Feature", value: "Unit", systemImage: "square.split.2x2")
            IMDFInspectorRow(title: "Geometry", value: "Polygon", systemImage: "skew")
            IMDFInspectorRow(title: "Ready") {
                IMDFStatusBadge("Blocked", systemImage: "xmark.circle", role: .warning)
            }
        }
    }
    .padding()
}
