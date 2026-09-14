import SwiftUI

public enum IMDFPanelStyle: Sendable {
    case floating
    case inspector
    case status
}

public extension EnvironmentValues {
    @Entry var imdfPanelStyle: IMDFPanelStyle = .floating
}

public extension View {
    func imdfPanelStyle(_ style: IMDFPanelStyle) -> some View {
        environment(\.imdfPanelStyle, style)
    }
}
