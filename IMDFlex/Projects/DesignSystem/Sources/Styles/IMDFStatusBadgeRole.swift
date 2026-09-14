import SwiftUI

public enum IMDFStatusBadgeRole: Equatable, Sendable {
    case info
    case success
    case warning
    case error
    case selected

    var tint: Color {
        switch self {
        case .info, .selected: IMDFColor.accent
        case .success: IMDFColor.success
        case .warning: IMDFColor.warning
        case .error: IMDFColor.danger
        }
    }

    var systemImage: String {
        switch self {
        case .info: DesignSystemSymbol.information
        case .success, .selected: DesignSystemSymbol.success
        case .warning: DesignSystemSymbol.warning
        case .error: DesignSystemSymbol.failure
        }
    }

    var accessibilityValue: String {
        switch self {
        case .info: DesignSystemText.information
        case .success: DesignSystemText.success
        case .warning: DesignSystemText.warning
        case .error: DesignSystemText.error
        case .selected: DesignSystemText.selected
        }
    }
}
