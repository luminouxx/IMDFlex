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

#Preview("Inspector Section") {
    IMDFPanel {
        IMDFInspectorSection(title: "Authoring") {
            IMDFInspectorRow("Feature", value: "Unit")
                .systemImage("square.split.2x2")
            IMDFInspectorRow("Geometry", value: "Polygon")
                .systemImage("skew")
            IMDFInspectorRow("Ready") {
                IMDFStatusBadge("Blocked").status(.warning)
            }
        }
    }
    .imdfPanelStyle(.inspector)
    .padding()
}
