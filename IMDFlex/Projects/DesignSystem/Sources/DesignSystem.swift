import SwiftUI

// MARK: - Colors

public extension Color {
    static let imdfPrimary = Color.blue
    static let imdfSecondary = Color.gray
    static let imdfBackground = Color(.systemBackground)
    static let imdfGroupedBackground = Color(.systemGroupedBackground)
}

// MARK: - Common Button Style

public struct IMDFButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.imdfPrimary)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

public extension ButtonStyle where Self == IMDFButtonStyle {
    static var imdf: IMDFButtonStyle { IMDFButtonStyle() }
}

// MARK: - Common Card View

public struct CardView<Content: View>: View {
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding()
            .background(Color.imdfBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
    }
}

// MARK: - Empty State View

public struct EmptyStateView: View {
    let title: String
    let message: String
    let systemImage: String
    
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
