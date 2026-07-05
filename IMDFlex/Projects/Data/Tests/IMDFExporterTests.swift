import Foundation
import XCTest
@testable import Data
import Domain

final class IMDFExporterTests: XCTestCase {
    func testExportIncludesManifestAndMVPGeoJSONFiles() async throws {
        let archive = try await IMDFExporter().export(sampleVenue())
        let entries = try ZipArchiveReader.entries(from: archive)

        XCTAssertEqual(
            Set(entries.keys),
            [
                "address.geojson",
                "amenity.geojson",
                "building.geojson",
                "footprint.geojson",
                "level.geojson",
                "manifest.json",
                "occupant.geojson",
                "opening.geojson",
                "unit.geojson",
                "venue.geojson"
            ]
        )
    }

    func testExportWritesIMDFManifestVersion() async throws {
        let archive = try await IMDFExporter().export(sampleVenue())
        let entries = try ZipArchiveReader.entries(from: archive)
        let manifestData = try XCTUnwrap(entries["manifest.json"])
        let manifest = try XCTUnwrap(JSONSerialization.jsonObject(with: manifestData) as? [String: Any])

        XCTAssertEqual(manifest["version"] as? String, "1.0.0")
    }

    func testExportWritesVenueFeatureCollection() async throws {
        let venue = sampleVenue()
        let archive = try await IMDFExporter().export(venue)
        let entries = try ZipArchiveReader.entries(from: archive)
        let venueCollection = try featureCollection(named: "venue.geojson", from: entries)
        let features = try XCTUnwrap(venueCollection["features"] as? [[String: Any]])
        let feature = try XCTUnwrap(features.first)

        XCTAssertEqual(venueCollection["type"] as? String, "FeatureCollection")
        XCTAssertEqual(features.count, 1)
        XCTAssertEqual(feature["id"] as? String, venue.id.uuidString)
        XCTAssertEqual(feature["feature_type"] as? String, "venue")
    }

    func testExportWritesCoreFeatureSchemaProperties() async throws {
        let venue = sampleVenue()
        let archive = try await IMDFExporter().export(venue)
        let entries = try ZipArchiveReader.entries(from: archive)
        let building = try XCTUnwrap(venue.buildings.first)
        let level = try XCTUnwrap(building.levels.first)

        let venueProperties = try properties(in: "venue.geojson", from: entries)
        let buildingProperties = try properties(in: "building.geojson", from: entries)
        let footprintProperties = try properties(in: "footprint.geojson", from: entries)
        let levelProperties = try properties(in: "level.geojson", from: entries)

        XCTAssertEqual(venueProperties["category"] as? String, "shoppingcenter")
        XCTAssertEqual(venueProperties["address_id"] as? String, venue.address?.id.uuidString)
        XCTAssertEqual(buildingProperties["category"] as? String, "unspecified")
        XCTAssertEqual(buildingProperties["venue_id"] as? String, venue.id.uuidString)
        XCTAssertEqual(footprintProperties["category"] as? String, "ground")
        XCTAssertEqual(footprintProperties["building_id"] as? String, building.id.uuidString)
        XCTAssertEqual(levelProperties["category"] as? String, "unspecified")
        XCTAssertEqual(levelProperties["building_id"] as? String, building.id.uuidString)
        XCTAssertEqual(levelProperties["ordinal"] as? Int, level.ordinal)
    }

    func testExportWritesCorePolygonGeometryAndDisplayPoints() async throws {
        let archive = try await IMDFExporter().export(sampleVenue())
        let entries = try ZipArchiveReader.entries(from: archive)

        let venueFeature = try singleFeature(in: "venue.geojson", from: entries)
        let venueGeometry = try geometry(from: venueFeature)
        let venueCoordinates = try polygonCoordinates(from: venueGeometry)
        let venueProperties = try XCTUnwrap(venueFeature["properties"] as? [String: Any])
        let venueDisplayPoint = try XCTUnwrap(venueProperties["display_point"] as? [String: Any])

        XCTAssertEqual(venueGeometry["type"] as? String, "Polygon")
        XCTAssertEqual(venueCoordinates.first?.first, [-122.03130, 37.33150])
        XCTAssertEqual(venueCoordinates.first?.last, [-122.03130, 37.33150])
        XCTAssertEqual(venueDisplayPoint["type"] as? String, "Point")

        let footprintGeometry = try geometry(in: "footprint.geojson", from: entries)
        let footprintCoordinates = try polygonCoordinates(from: footprintGeometry)
        XCTAssertEqual(footprintGeometry["type"] as? String, "Polygon")
        XCTAssertEqual(footprintCoordinates.first?.first, [-122.03120, 37.33160])
        XCTAssertEqual(footprintCoordinates.first?.last, [-122.03120, 37.33160])

        let levelFeature = try singleFeature(in: "level.geojson", from: entries)
        let levelGeometry = try geometry(from: levelFeature)
        let levelProperties = try XCTUnwrap(levelFeature["properties"] as? [String: Any])
        XCTAssertEqual(levelGeometry["type"] as? String, "Polygon")
        XCTAssertNotNil(levelProperties["display_point"])
    }

    private func sampleVenue() -> Venue {
        let unitCoordinates = [
            Coordinate(latitude: 37.33170, longitude: -122.03110),
            Coordinate(latitude: 37.33170, longitude: -122.03090),
            Coordinate(latitude: 37.33190, longitude: -122.03090),
            Coordinate(latitude: 37.33190, longitude: -122.03110)
        ]
        let footprintCoordinates = [
            Coordinate(latitude: 37.33160, longitude: -122.03120),
            Coordinate(latitude: 37.33160, longitude: -122.03080),
            Coordinate(latitude: 37.33200, longitude: -122.03080),
            Coordinate(latitude: 37.33200, longitude: -122.03120)
        ]
        let venueCoordinates = [
            Coordinate(latitude: 37.33150, longitude: -122.03130),
            Coordinate(latitude: 37.33150, longitude: -122.03070),
            Coordinate(latitude: 37.33210, longitude: -122.03070),
            Coordinate(latitude: 37.33210, longitude: -122.03130)
        ]
        let unit = Unit(
            name: "Lobby",
            category: .lobby,
            coordinates: unitCoordinates
        )
        let level = Level(
            name: "Level 1",
            category: .unspecified,
            ordinal: 0,
            shortName: "1F",
            coordinates: footprintCoordinates,
            units: [unit]
        )
        let footprint = Footprint(
            category: .ground,
            coordinates: footprintCoordinates
        )
        let building = Building(
            name: "Main Building",
            category: .unspecified,
            levels: [level],
            footprint: footprint
        )
        let address = Address(
            address: "1 Infinite Loop",
            locality: "Cupertino",
            province: "CA",
            country: "US",
            postalCode: "95014"
        )

        return Venue(
            name: "IMDFlex Test Venue",
            category: .shoppingCenter,
            coordinates: venueCoordinates,
            buildings: [building],
            address: address
        )
    }

    private func featureCollection(
        named fileName: String,
        from entries: [String: Data]
    ) throws -> [String: Any] {
        let data = try XCTUnwrap(entries[fileName])
        return try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? [String: Any])
    }

    private func singleFeature(in fileName: String, from entries: [String: Data]) throws -> [String: Any] {
        let collection = try featureCollection(named: fileName, from: entries)
        let features = try XCTUnwrap(collection["features"] as? [[String: Any]])
        return try XCTUnwrap(features.first)
    }

    private func properties(in fileName: String, from entries: [String: Data]) throws -> [String: Any] {
        let feature = try singleFeature(in: fileName, from: entries)
        return try XCTUnwrap(feature["properties"] as? [String: Any])
    }

    private func geometry(in fileName: String, from entries: [String: Data]) throws -> [String: Any] {
        let feature = try singleFeature(in: fileName, from: entries)
        return try geometry(from: feature)
    }

    private func geometry(from feature: [String: Any]) throws -> [String: Any] {
        try XCTUnwrap(feature["geometry"] as? [String: Any])
    }

    private func polygonCoordinates(from geometry: [String: Any]) throws -> [[[Double]]] {
        try XCTUnwrap(geometry["coordinates"] as? [[[Double]]])
    }
}

private enum ZipArchiveReader {
    static func entries(from archive: Data) throws -> [String: Data] {
        var offset = 0
        var entries: [String: Data] = [:]

        while offset + 4 <= archive.count {
            let signature = try archive.uint32LE(at: offset)
            guard signature == 0x04034b50 else { break }
            guard offset + 30 <= archive.count else { throw ZipArchiveReaderError.invalidArchive }

            let compressionMethod = try archive.uint16LE(at: offset + 8)
            guard compressionMethod == 0 else {
                throw ZipArchiveReaderError.unsupportedCompressionMethod(compressionMethod)
            }

            let compressedSize = Int(try archive.uint32LE(at: offset + 18))
            let fileNameLength = Int(try archive.uint16LE(at: offset + 26))
            let extraFieldLength = Int(try archive.uint16LE(at: offset + 28))
            let fileNameStart = offset + 30
            let fileNameEnd = fileNameStart + fileNameLength
            let fileDataStart = fileNameEnd + extraFieldLength
            let fileDataEnd = fileDataStart + compressedSize

            guard fileNameEnd <= archive.count, fileDataEnd <= archive.count else {
                throw ZipArchiveReaderError.invalidArchive
            }
            guard let fileName = String(data: archive[fileNameStart..<fileNameEnd], encoding: .utf8) else {
                throw ZipArchiveReaderError.invalidFileName
            }

            entries[fileName] = Data(archive[fileDataStart..<fileDataEnd])
            offset = fileDataEnd
        }

        return entries
    }
}

private enum ZipArchiveReaderError: Error {
    case invalidArchive
    case invalidFileName
    case unsupportedCompressionMethod(UInt16)
}

private extension Data {
    func uint16LE(at offset: Int) throws -> UInt16 {
        guard offset + 2 <= count else { throw ZipArchiveReaderError.invalidArchive }
        return UInt16(self[offset]) | (UInt16(self[offset + 1]) << 8)
    }

    func uint32LE(at offset: Int) throws -> UInt32 {
        guard offset + 4 <= count else { throw ZipArchiveReaderError.invalidArchive }
        return UInt32(self[offset])
            | (UInt32(self[offset + 1]) << 8)
            | (UInt32(self[offset + 2]) << 16)
            | (UInt32(self[offset + 3]) << 24)
    }
}
