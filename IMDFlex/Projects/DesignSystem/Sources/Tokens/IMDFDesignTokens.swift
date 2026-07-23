import SwiftUI

public enum IMDFColor {
    public static let accent = Color(red: 0.00, green: 0.42, blue: 1.00)
    public static let accentMuted = Color(red: 0.83, green: 0.91, blue: 1.00)
    public static let success = Color(red: 0.08, green: 0.55, blue: 0.31)
    public static let warning = Color(red: 0.84, green: 0.48, blue: 0.00)
    public static let danger = Color(red: 0.82, green: 0.16, blue: 0.18)
    public static let selection = Color(red: 0.00, green: 0.42, blue: 1.00)
    public static let gridLine = Color.primary.opacity(0.12)
    public static let separator = Color.primary.opacity(0.14)
}

public enum IMDFSpacing {
    public static let xxs: CGFloat = 2
    public static let xs: CGFloat = 4
    public static let sm: CGFloat = 8
    public static let md: CGFloat = 12
    public static let lg: CGFloat = 16
    public static let xl: CGFloat = 24
}

public enum IMDFRadius {
    public static let sm: CGFloat = 4
    public static let md: CGFloat = 6
    public static let lg: CGFloat = 8
}

public enum IMDFIconSize {
    public static let sm: CGFloat = 16
    public static let md: CGFloat = 20
    public static let lg: CGFloat = 24
}

public enum IMDFFont {
    public static let badge = Font.caption.weight(.semibold)
    public static let toolLabel = Font.caption2.weight(.medium)
    public static let inspectorLabel = Font.subheadline
    public static let inspectorValue = Font.subheadline.weight(.medium)
    public static let panelTitle = Font.headline
}

public extension Color {
    static let imdfPrimary = IMDFColor.accent
    static let imdfSecondary = Color.secondary
    static let imdfBackground = Color.clear
    static let imdfGroupedBackground = Color.primary.opacity(0.04)
}
