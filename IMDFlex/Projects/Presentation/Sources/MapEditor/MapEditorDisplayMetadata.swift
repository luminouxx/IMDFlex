extension IMDFAuthoringFeature {
    var title: String {
        switch self {
        case .address: MapEditorText.address
        case .venue: MapEditorText.venue
        case .building: MapEditorText.building
        case .footprint: MapEditorText.footprint
        case .level: MapEditorText.level
        case .unit: MapEditorText.unit
        case .opening: MapEditorText.opening
        case .amenity: MapEditorText.amenity
        case .anchor: MapEditorText.anchor
        case .occupant: MapEditorText.occupant
        case .detail: MapEditorText.detail
        case .fixture: MapEditorText.fixture
        case .geofence: MapEditorText.geofence
        case .kiosk: MapEditorText.kiosk
        case .relationship: MapEditorText.relationship
        case .section: MapEditorText.section
        }
    }

    var systemImage: String {
        MapEditorSymbol.feature(self)
    }
}

extension IMDFAuthoringGeometry {
    var title: String {
        switch self {
        case .point: MapEditorText.point
        case .line: MapEditorText.line
        case .polygon: MapEditorText.polygon
        case .form: MapEditorText.form
        }
    }

    var systemImage: String {
        MapEditorSymbol.geometry(self)
    }
}

extension IMDFAuthoringReference {
    var title: String {
        switch self {
        case .building: MapEditorText.building
        case .level: MapEditorText.level
        case .unit: MapEditorText.unit
        case .anchor: MapEditorText.anchor
        case .levelOrBuilding: MapEditorText.levelOrBuilding
        case .relationshipEndpoints: MapEditorText.endpoints
        }
    }
}
