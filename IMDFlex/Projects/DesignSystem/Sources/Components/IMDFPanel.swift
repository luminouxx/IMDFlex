import SwiftUI

public enum IMDFPanelStyleRole: Sendable {
    case floating
    case inspector
    case status
}

public struct IMDFPanel<Content: View>: View {
    private let role: IMDFPanelStyleRole
    private let content: Content

    public init(
        role: IMDFPanelStyleRole = .floating,
        @ViewBuilder content: () -> Content
    ) {
        self.role = role
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .background(backgroundStyle)
            .overlay {
                RoundedRectangle(cornerRadius: IMDFRadius.lg, style: .continuous)
                    .stroke(IMDFColor.separator, lineWidth: 1)
            }
            .clipShape(.rect(cornerRadius: IMDFRadius.lg, style: .continuous))
            .shadow(color: shadowColor, radius: shadowRadius, y: shadowYOffset)
    }

    private var padding: CGFloat {
        switch role {
        case .floating: IMDFSpacing.sm
        case .inspector: IMDFSpacing.lg
        case .status: IMDFSpacing.md
        }
    }

    private var backgroundStyle: AnyShapeStyle {
        switch role {
        case .floating:
            AnyShapeStyle(.ultraThinMaterial)
        case .inspector:
            AnyShapeStyle(.regularMaterial)
        case .status:
            AnyShapeStyle(.thinMaterial)
        }
    }

    private var shadowColor: Color {
        switch role {
        case .floating: Color.black.opacity(0.14)
        case .inspector: Color.black.opacity(0.10)
        case .status: Color.black.opacity(0.08)
        }
    }

    private var shadowRadius: CGFloat {
        switch role {
        case .floating: 12
        case .inspector: 8
        case .status: 6
        }
    }

    private var shadowYOffset: CGFloat {
        switch role {
        case .floating: 6
        case .inspector: 4
        case .status: 3
        }
    }
}

public typealias CardView = IMDFPanel

#Preview("Panels") {
    VStack(spacing: IMDFSpacing.lg) {
        IMDFPanel(role: .floating) {
            Text("Floating Toolbar")
        }

        IMDFPanel(role: .inspector) {
            VStack(alignment: .leading, spacing: IMDFSpacing.sm) {
                Text("Inspector")
                    .font(IMDFFont.panelTitle)
                Text("Selected feature properties")
                    .font(IMDFFont.inspectorLabel)
                    .foregroundStyle(.secondary)
            }
        }

        IMDFPanel(role: .status) {
            IMDFStatusBadge("Preflight Ready", systemImage: "checkmark.circle", role: .success)
        }
    }
    .padding()
}
