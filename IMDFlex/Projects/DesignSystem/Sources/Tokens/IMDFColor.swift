import SwiftUI

public enum IMDFColor {
    public static let accent = Color("IMDFAccent", bundle: .imdfDesignSystem)
    public static let accentFill = Color("IMDFAccentFill", bundle: .imdfDesignSystem)
    public static let accentFillPressed = Color("IMDFAccentPressed", bundle: .imdfDesignSystem)
    public static let success = Color("IMDFSuccess", bundle: .imdfDesignSystem)
    public static let warning = Color("IMDFWarning", bundle: .imdfDesignSystem)
    public static let danger = Color("IMDFDanger", bundle: .imdfDesignSystem)
    public static let dangerFill = Color("IMDFDangerFill", bundle: .imdfDesignSystem)
    public static let dangerFillPressed = Color("IMDFDangerFillPressed", bundle: .imdfDesignSystem)
    public static let selection = accent
    public static let neutralFill = Color.primary.opacity(0.055)
    public static let selectedFill = accent.opacity(0.14)
    public static let gridLine = Color.primary.opacity(0.08)
    public static let separator = Color.primary.opacity(0.14)
}

public extension Color {
    static let imdfPrimary = IMDFColor.accent
    static let imdfSecondary = Color.secondary
    static let imdfGroupedBackground = IMDFColor.neutralFill
}
