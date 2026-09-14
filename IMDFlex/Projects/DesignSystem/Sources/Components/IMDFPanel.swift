import SwiftUI

public struct IMDFPanel<Content: View>: View {
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.imdfLayoutMode) private var layoutMode
    @Environment(\.imdfPanelStyle) private var style

    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .background(backgroundStyle)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(IMDFColor.separator, lineWidth: 1)
            }
            .clipShape(.rect(cornerRadius: cornerRadius))
            .shadow(color: shadowColor, radius: shadowRadius, y: shadowYOffset)
    }

    private var padding: CGFloat {
        switch style {
        case .floating: IMDFSpacing.sm
        case .inspector: IMDFSpacing.lg
        case .status: IMDFSpacing.md
        }
    }

    private var backgroundStyle: AnyShapeStyle {
        if reduceTransparency {
            return AnyShapeStyle(.background)
        }

        switch style {
        case .floating:
            return AnyShapeStyle(.ultraThinMaterial)
        case .inspector:
            return AnyShapeStyle(.regularMaterial)
        case .status:
            return AnyShapeStyle(.thinMaterial)
        }
    }

    private var shadowColor: Color {
        switch style {
        case .floating: Color.black.opacity(0.14)
        case .inspector: Color.black.opacity(0.10)
        case .status: Color.black.opacity(0.08)
        }
    }

    private var shadowRadius: CGFloat {
        switch style {
        case .floating: 12
        case .inspector: 8
        case .status: 6
        }
    }

    private var shadowYOffset: CGFloat {
        switch style {
        case .floating: 6
        case .inspector: 4
        case .status: 3
        }
    }

    private var cornerRadius: CGFloat {
        layoutMode == .compact ? IMDFRadius.compactPanel : IMDFRadius.panel
    }
}

#Preview("Panels") {
    VStack(spacing: IMDFSpacing.lg) {
        IMDFPanel {
            Text("Floating Toolbar")
        }

        IMDFPanel {
            VStack(alignment: .leading, spacing: IMDFSpacing.sm) {
                Text("Inspector")
                    .font(IMDFFont.panelTitle)
                Text("Selected feature properties")
                    .font(IMDFFont.inspectorLabel)
                    .foregroundStyle(.secondary)
            }
        }
        .imdfPanelStyle(.inspector)

        IMDFPanel {
            IMDFStatusBadge("Preflight Ready").status(.success)
        }
        .imdfPanelStyle(.status)
    }
    .padding()
}
