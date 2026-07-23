import SwiftUI

public struct EmptyStateView: View {
    private let title: String
    private let message: String
    private let systemImage: String

    public init(title: String, message: String, systemImage: String) {
        self.title = title
        self.message = message
        self.systemImage = systemImage
    }

    public var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: systemImage)
        } description: {
            Text(message)
        }
    }
}

#Preview("Empty State") {
    EmptyStateView(
        title: "No Projects",
        message: "Create a project to begin indoor map authoring.",
        systemImage: "map"
    )
}
