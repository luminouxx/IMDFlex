import Foundation

enum DesignSystemText {
    static let readOnly = localized("designSystem.accessibility.readOnly", defaultValue: "Read only")
    static let complete = localized("designSystem.accessibility.complete", defaultValue: "Complete")
    static let actionRequired = localized(
        "designSystem.accessibility.actionRequired",
        defaultValue: "Action required"
    )
    static let selected = localized("designSystem.accessibility.selected", defaultValue: "Selected")
    static let notSelected = localized(
        "designSystem.accessibility.notSelected",
        defaultValue: "Not selected"
    )
    static let information = localized("designSystem.status.information", defaultValue: "Information")
    static let success = localized("designSystem.status.success", defaultValue: "Success")
    static let warning = localized("designSystem.status.warning", defaultValue: "Warning")
    static let error = localized("designSystem.status.error", defaultValue: "Error")

    private static func localized(
        _ key: StaticString,
        defaultValue: String.LocalizationValue
    ) -> String {
        String(
            localized: key,
            defaultValue: defaultValue,
            bundle: .imdfDesignSystem
        )
    }
}
