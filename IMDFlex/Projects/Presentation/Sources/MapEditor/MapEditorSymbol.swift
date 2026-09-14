enum MapEditorSymbol {
    static let export = "square.and.arrow.up"
    static let settings = "gear"
    static let more = "ellipsis.circle"
    static let draftPoints = "point.3.connected.trianglepath.dotted"
    static let ready = "checkmark.circle"
    static let readyFilled = "checkmark.circle.fill"
    static let draft = "clock"
    static let draftFilled = "clock.fill"
    static let add = "plus"
    static let remove = "minus"
    static let cancel = "xmark"
    static let finish = "checkmark"

    static func feature(_ feature: IMDFAuthoringFeature) -> String {
        switch feature {
        case .address: "mappin.and.ellipse"
        case .venue: "map"
        case .building: "building.2"
        case .footprint: "skew"
        case .level: "square.stack.3d.up"
        case .unit: "square.split.2x2"
        case .opening: "door.left.hand.open"
        case .amenity: "fork.knife"
        case .anchor: "pin"
        case .occupant: "person.crop.square"
        case .detail: "line.diagonal"
        case .fixture: "table.furniture"
        case .geofence: "location.viewfinder"
        case .kiosk: "display"
        case .relationship: "point.3.connected.trianglepath.dotted"
        case .section: "rectangle.3.group"
        }
    }

    static func geometry(_ geometry: IMDFAuthoringGeometry) -> String {
        switch geometry {
        case .point: "smallcircle.filled.circle"
        case .line: "line.diagonal"
        case .polygon: "skew"
        case .form: "list.bullet.rectangle"
        }
    }
}
