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
        let venueData = try XCTUnwrap(entries["venue.geojson"])
        let venueCollection = try XCTUnwrap(JSONSerialization.jsonObject(with: venueData) as? [String: Any])
        let features = try XCTUnwrap(venueCollection["features"] as? [[String: Any]])
        let feature = try XCTUnwrap(features.first)

        XCTAssertEqual(venueCollection["type"] as? String, "FeatureCollection")
        XCTAssertEqual(features.count, 1)
        XCTAssertEqual(feature["id"] as? String, venue.id.uuidString)
        XCTAssertEqual(feature["feature_type"] as? String, "venue")
    }

    private func sampleVenue() -> Venue {
        let unit = Unit(
            name: "Lobby",
            category: .lobby,
            coordinates: [
                Coordinate(latitude: 37.33170, longitude: -122.03110),
                Coordinate(latitude: 37.33170, longitude: -122.03090),
                Coordinate(latitude: 37.33190, longitude: -122.03090),
                Coordinate(latitude: 37.33190, longitude: -122.03110)
            ]
        )
        let level = Level(name: "Level 1", ordinal: 0, shortName: "1F", units: [unit])
        let footprint = Footprint(
            coordinates: [
                Coordinate(latitude: 37.33160, longitude: -122.03120),
                Coordinate(latitude: 37.33160, longitude: -122.03080),
                Coordinate(latitude: 37.33200, longitude: -122.03080),
                Coordinate(latitude: 37.33200, longitude: -122.03120)
            ]
        )
        let building = Building(name: "Main Building", levels: [level], footprint: footprint)
        let address = Address(
            address: "1 Infinite Loop",
            locality: "Cupertino",
            province: "CA",
            country: "US",
            postalCode: "95014"
        )

        return Venue(
            name: "IMDFlex Test Venue",
            category: .university,
            buildings: [building],
            address: address
        )
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
