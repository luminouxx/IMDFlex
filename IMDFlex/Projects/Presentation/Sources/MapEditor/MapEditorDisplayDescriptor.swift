import Foundation

public struct IMDFAuthoringFeatureDisplayDescriptor: Equatable, Identifiable, Sendable {
    public let feature: IMDFAuthoringFeature
    public let title: String
    public let systemImage: String

    public var id: IMDFAuthoringFeature {
        feature
    }

    public init(
        feature: IMDFAuthoringFeature,
        title: String,
        systemImage: String
    ) {
        self.feature = feature
        self.title = title
        self.systemImage = systemImage
    }
}

public struct IMDFAuthoringGeometryDisplayDescriptor: Equatable, Sendable {
    public let geometry: IMDFAuthoringGeometry
    public let title: String
    public let systemImage: String

    public init(
        geometry: IMDFAuthoringGeometry,
        title: String,
        systemImage: String
    ) {
        self.geometry = geometry
        self.title = title
        self.systemImage = systemImage
    }
}

public struct IMDFAuthoringReferenceDisplayDescriptor: Equatable, Sendable {
    public let reference: IMDFAuthoringReference
    public let title: String

    public init(
        reference: IMDFAuthoringReference,
        title: String
    ) {
        self.reference = reference
        self.title = title
    }
}

public enum MapEditorDisplayDescriptor {
    public static let features: [IMDFAuthoringFeatureDisplayDescriptor] = IMDFAuthoringFeature.allCases.map {
        featureDescriptor(for: $0)
    }

    public static func featureDescriptor(
        for feature: IMDFAuthoringFeature
    ) -> IMDFAuthoringFeatureDisplayDescriptor {
        switch feature {
        case .address:
            .init(feature: feature, title: "Address", systemImage: "mappin.and.ellipse")
        case .venue:
            .init(feature: feature, title: "Venue", systemImage: "map")
        case .building:
            .init(feature: feature, title: "Building", systemImage: "building.2")
        case .footprint:
            .init(feature: feature, title: "Footprint", systemImage: "skew")
        case .level:
            .init(feature: feature, title: "Level", systemImage: "square.stack.3d.up")
        case .unit:
            .init(feature: feature, title: "Unit", systemImage: "square.split.2x2")
        case .opening:
            .init(feature: feature, title: "Opening", systemImage: "door.left.hand.open")
        case .amenity:
            .init(feature: feature, title: "Amenity", systemImage: "fork.knife")
        case .anchor:
            .init(feature: feature, title: "Anchor", systemImage: "pin")
        case .occupant:
            .init(feature: feature, title: "Occupant", systemImage: "person.crop.square")
        case .detail:
            .init(feature: feature, title: "Detail", systemImage: "line.diagonal")
        case .fixture:
            .init(feature: feature, title: "Fixture", systemImage: "table.furniture")
        case .geofence:
            .init(feature: feature, title: "Geofence", systemImage: "location.viewfinder")
        case .kiosk:
            .init(feature: feature, title: "Kiosk", systemImage: "display")
        case .relationship:
            .init(feature: feature, title: "Relationship", systemImage: "point.3.connected.trianglepath.dotted")
        case .section:
            .init(feature: feature, title: "Section", systemImage: "rectangle.3.group")
        }
    }

    public static func geometryDescriptor(
        for geometry: IMDFAuthoringGeometry
    ) -> IMDFAuthoringGeometryDisplayDescriptor {
        switch geometry {
        case .point:
            .init(geometry: geometry, title: "Point", systemImage: "smallcircle.filled.circle")
        case .line:
            .init(geometry: geometry, title: "Line", systemImage: "line.diagonal")
        case .polygon:
            .init(geometry: geometry, title: "Polygon", systemImage: "skew")
        case .form:
            .init(geometry: geometry, title: "Form", systemImage: "list.bullet.rectangle")
        }
    }

    public static func referenceDescriptor(
        for reference: IMDFAuthoringReference
    ) -> IMDFAuthoringReferenceDisplayDescriptor {
        switch reference {
        case .building:
            .init(reference: reference, title: "Building")
        case .level:
            .init(reference: reference, title: "Level")
        case .unit:
            .init(reference: reference, title: "Unit")
        case .anchor:
            .init(reference: reference, title: "Anchor")
        case .levelOrBuilding:
            .init(reference: reference, title: "Level or building")
        case .relationshipEndpoints:
            .init(reference: reference, title: "Endpoints")
        }
    }
}
