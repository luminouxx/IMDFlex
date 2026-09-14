import SwiftUI

public enum IMDFLayoutMode: CaseIterable, Equatable, Sendable {
    case compact
    case intermediate
    case regular

    public var contentPadding: CGFloat {
        switch self {
        case .compact: IMDFSpacing.lg
        case .intermediate: IMDFSpacing.xl
        case .regular: IMDFSpacing.xxl
        }
    }

    public var inspectorWidth: CGFloat? {
        switch self {
        case .compact: nil
        case .intermediate: 320
        case .regular: 360
        }
    }
}

public extension EnvironmentValues {
    @Entry var imdfLayoutMode: IMDFLayoutMode = .regular
}

public extension View {
    func imdfLayoutMode(_ mode: IMDFLayoutMode) -> some View {
        environment(\.imdfLayoutMode, mode)
    }
}
