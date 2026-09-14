import SwiftUI

public struct IMDFInspectorRow<Trailing: View>: View {
    private let title: String
    private let trailing: Trailing
    private var systemImage: String?

    public init(
        _ title: String,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.trailing = trailing()
    }

    public var body: some View {
        LabeledContent {
            trailing
                .font(IMDFFont.inspectorValue)
                .foregroundStyle(.primary)
        } label: {
            if let systemImage {
                Label(title, systemImage: systemImage)
                    .labelStyle(.titleAndIcon)
                    .foregroundStyle(.secondary)
            } else {
                Text(title)
                    .foregroundStyle(.secondary)
            }
        }
        .font(IMDFFont.inspectorLabel)
        .frame(minHeight: IMDFControlMetrics.statusHeight)
        .accessibilityElement(children: .combine)
    }

    public func systemImage(_ systemImage: String?) -> Self {
        var copy = self
        copy.systemImage = systemImage
        return copy
    }
}

public extension IMDFInspectorRow where Trailing == Text {
    init(_ title: String, value: String) {
        self.init(title) {
            Text(value)
        }
    }
}
