import Foundation
import Domain

/// IMDF GeoJSON 내보내기
public final class IMDFExporter: IMDFExporterProtocol, Sendable {
    
    public init() {}
    
    public func export(_ venue: Venue) async throws -> Data {
        // IMDF Archive는 여러 GeoJSON 파일의 ZIP
        // 간단히 venue.geojson만 우선 구현
        let geoJSON = try buildVenueGeoJSON(venue)
        return try JSONSerialization.data(withJSONObject: geoJSON, options: .prettyPrinted)
    }
    
    private func buildVenueGeoJSON(_ venue: Venue) throws -> [String: Any] {
        [
            "type": "FeatureCollection",
            "features": [
                [
                    "type": "Feature",
                    "id": venue.id.uuidString,
                    "feature_type": "venue",
                    "properties": [
                        "name": venue.name,
                        "category": venue.category.rawValue
                    ],
                    "geometry": NSNull()
                ]
            ]
        ]
    }
}
