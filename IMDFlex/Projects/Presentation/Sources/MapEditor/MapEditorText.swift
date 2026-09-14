import Foundation

enum MapEditorText {
    static let export = localized("mapEditor.action.export", defaultValue: "Export")
    static let settings = localized("mapEditor.action.settings", defaultValue: "Settings")
    static let editorActions = localized("mapEditor.accessibility.editorActions", defaultValue: "Editor actions")
    static let geometry = localized("mapEditor.inspector.geometry", defaultValue: "Geometry")
    static let draftPoints = localized("mapEditor.inspector.draftPoints", defaultValue: "Draft points")
    static let status = localized("mapEditor.inspector.status", defaultValue: "Status")
    static let ready = localized("mapEditor.status.ready", defaultValue: "Ready")
    static let draft = localized("mapEditor.status.draft", defaultValue: "Draft")
    static let requirements = localized("mapEditor.inspector.requirements", defaultValue: "Requirements")
    static let category = localized("mapEditor.requirement.category", defaultValue: "Category")
    static let selected = localized("mapEditor.requirement.selected", defaultValue: "Selected")
    static let required = localized("mapEditor.requirement.required", defaultValue: "Required")
    static let references = localized("mapEditor.requirement.references", defaultValue: "References")
    static let none = localized("mapEditor.requirement.none", defaultValue: "None")
    static let linked = localized("mapEditor.requirement.linked", defaultValue: "Linked")
    static let addPoint = localized("mapEditor.action.addPoint", defaultValue: "Add point")
    static let removePoint = localized("mapEditor.action.removePoint", defaultValue: "Remove point")
    static let cancelDraft = localized("mapEditor.action.cancelDraft", defaultValue: "Cancel draft")
    static let finishDraft = localized("mapEditor.action.finishDraft", defaultValue: "Finish draft")

    static let address = localized("mapEditor.feature.address", defaultValue: "Address")
    static let venue = localized("mapEditor.feature.venue", defaultValue: "Venue")
    static let building = localized("mapEditor.feature.building", defaultValue: "Building")
    static let footprint = localized("mapEditor.feature.footprint", defaultValue: "Footprint")
    static let level = localized("mapEditor.feature.level", defaultValue: "Level")
    static let unit = localized("mapEditor.feature.unit", defaultValue: "Unit")
    static let opening = localized("mapEditor.feature.opening", defaultValue: "Opening")
    static let amenity = localized("mapEditor.feature.amenity", defaultValue: "Amenity")
    static let anchor = localized("mapEditor.feature.anchor", defaultValue: "Anchor")
    static let occupant = localized("mapEditor.feature.occupant", defaultValue: "Occupant")
    static let detail = localized("mapEditor.feature.detail", defaultValue: "Detail")
    static let fixture = localized("mapEditor.feature.fixture", defaultValue: "Fixture")
    static let geofence = localized("mapEditor.feature.geofence", defaultValue: "Geofence")
    static let kiosk = localized("mapEditor.feature.kiosk", defaultValue: "Kiosk")
    static let relationship = localized("mapEditor.feature.relationship", defaultValue: "Relationship")
    static let section = localized("mapEditor.feature.section", defaultValue: "Section")

    static let point = localized("mapEditor.geometry.point", defaultValue: "Point")
    static let line = localized("mapEditor.geometry.line", defaultValue: "Line")
    static let polygon = localized("mapEditor.geometry.polygon", defaultValue: "Polygon")
    static let form = localized("mapEditor.geometry.form", defaultValue: "Form")

    static let levelOrBuilding = localized("mapEditor.reference.levelOrBuilding", defaultValue: "Level or building")
    static let endpoints = localized("mapEditor.reference.endpoints", defaultValue: "Endpoints")

    private static let draftProgressFormat = localized(
        "mapEditor.draft.progressFormat",
        defaultValue: "%1$lld/%2$lld"
    )

    static func draftProgress(current: Int, required: Int) -> String {
        String(format: draftProgressFormat, locale: .current, current, required)
    }

    static func referenceList(_ references: [String]) -> String {
        references.formatted(.list(type: .and, width: .narrow))
    }

    private static func localized(
        _ key: StaticString,
        defaultValue: String.LocalizationValue
    ) -> String {
        String(
            localized: key,
            defaultValue: defaultValue,
            bundle: .imdfPresentation
        )
    }
}
