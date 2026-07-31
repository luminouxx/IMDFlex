import Foundation
import Observation

public struct IMDFDraftCoordinate: Codable, Equatable, Hashable, Sendable {
    public let longitude: Double
    public let latitude: Double

    public init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }

    public var geoJSONPosition: [Double] {
        [longitude, latitude]
    }
}

public struct IMDFDrawingDraftResult: Equatable, Sendable {
    public let geometry: IMDFAuthoringGeometry
    public let coordinates: [IMDFDraftCoordinate]

    public init(
        geometry: IMDFAuthoringGeometry,
        coordinates: [IMDFDraftCoordinate]
    ) {
        self.geometry = geometry
        self.coordinates = coordinates
    }
}

@MainActor
@Observable
public final class DrawingDraftState {
    public private(set) var geometry: IMDFAuthoringGeometry
    public private(set) var coordinates: [IMDFDraftCoordinate]

    public init(
        geometry: IMDFAuthoringGeometry,
        coordinates: [IMDFDraftCoordinate] = []
    ) {
        self.geometry = geometry
        self.coordinates = coordinates
    }

    public var pointCount: Int {
        coordinates.count
    }

    public var minimumPointCount: Int {
        geometry.minimumPointCount
    }

    public var remainingPointCount: Int {
        max(0, minimumPointCount - pointCount)
    }

    public var canFinish: Bool {
        pointCount >= minimumPointCount
    }

    public func setGeometry(_ geometry: IMDFAuthoringGeometry) {
        self.geometry = geometry
        clear()
    }

    public func append(_ coordinate: IMDFDraftCoordinate) {
        guard geometry != .form else { return }
        coordinates.append(coordinate)
    }

    public func removeLastCoordinate() {
        guard !coordinates.isEmpty else { return }
        coordinates.removeLast()
    }

    public func clear() {
        coordinates = []
    }

    public func finish() -> IMDFDrawingDraftResult? {
        guard canFinish else { return nil }

        return IMDFDrawingDraftResult(
            geometry: geometry,
            coordinates: coordinates
        )
    }
}
