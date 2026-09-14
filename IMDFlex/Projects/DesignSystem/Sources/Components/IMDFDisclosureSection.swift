import SwiftUI

public struct IMDFDisclosureSection<Content: View>: View {
    @Binding private var isExpanded: Bool

    private let title: String
    private let content: Content
    private var systemImage: String?

    public init(
        _ title: String,
        isExpanded: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        _isExpanded = isExpanded
        self.content = content()
    }

    public var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: IMDFSpacing.sm) {
                content
            }
            .padding(.top, IMDFSpacing.sm)
        } label: {
            if let systemImage {
                Label(title, systemImage: systemImage)
                    .font(IMDFFont.panelTitle)
            } else {
                Text(title)
                    .font(IMDFFont.panelTitle)
            }
        }
        .tint(IMDFColor.accent)
    }

    public func systemImage(_ systemImage: String?) -> Self {
        var copy = self
        copy.systemImage = systemImage
        return copy
    }
}

#Preview("Disclosure Section") {
    @Previewable @State var isExpanded = true

    IMDFDisclosureSection("Advanced properties", isExpanded: $isExpanded) {
        Text("Feature references")
            .font(.body)
    }
    .systemImage("slider.horizontal.3")
    .padding()
}
