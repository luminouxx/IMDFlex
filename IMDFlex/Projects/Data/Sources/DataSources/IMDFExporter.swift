import Foundation
import Domain

/// Builds an IMDF archive from the app's project model.
public final class IMDFExporter: IMDFExporterProtocol, Sendable {
    public init() {}

    public func export(_ venue: Venue) async throws -> Data {
        let files = try IMDFArchiveBuilder(venue: venue).makeFiles()
        return try ZipArchiveWriter(files: files).makeArchive()
    }
}

private struct IMDFArchiveBuilder {
    let venue: Venue

    func makeFiles() throws -> [String: Data] {
        var files: [String: Data] = [:]

        files["manifest.json"] = try encode(manifest())
        files["address.geojson"] = try encode(collection(addressFeatures()))
        files["venue.geojson"] = try encode(collection([venueFeature()]))
        files["building.geojson"] = try encode(collection(buildingFeatures()))
        files["footprint.geojson"] = try encode(collection(footprintFeatures()))
        files["level.geojson"] = try encode(collection(levelFeatures()))
        files["unit.geojson"] = try encode(collection(unitFeatures()))
        files["opening.geojson"] = try encode(collection(openingFeatures()))
        files["amenity.geojson"] = try encode(collection(amenityFeatures()))
        files["occupant.geojson"] = try encode(collection(occupantFeatures()))

        return files
    }

    private func manifest() -> [String: Any] {
        [
            "version": "1.0.0"
        ]
    }

    private func collection(_ features: [[String: Any]]) -> [String: Any] {
        [
            "type": "FeatureCollection",
            "features": features
        ]
    }

    private func encode(_ object: [String: Any]) throws -> Data {
        try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys])
    }

    private func addressFeatures() -> [[String: Any]] {
        guard let address = venue.address else { return [] }

        return [
            feature(
                id: address.id,
                featureType: "address",
                geometry: NSNull(),
                properties: compact([
                    "address": address.address,
                    "locality": address.locality,
                    "province": address.province,
                    "country": address.country,
                    "postal_code": address.postalCode
                ])
            )
        ]
    }

    private func venueFeature() -> [String: Any] {
        feature(
            id: venue.id,
            featureType: "venue",
            geometry: NSNull(),
            properties: compact([
                "name": localized(venue.name),
                "category": venue.category.rawValue,
                "address_id": venue.address?.id.uuidString
            ])
        )
    }

    private func buildingFeatures() -> [[String: Any]] {
        venue.buildings.map { building in
            feature(
                id: building.id,
                featureType: "building",
                geometry: NSNull(),
                properties: compact([
                    "name": localized(building.name),
                    "venue_id": venue.id.uuidString
                ])
            )
        }
    }

    private func footprintFeatures() -> [[String: Any]] {
        venue.buildings.compactMap { building in
            guard let footprint = building.footprint else { return nil }

            return feature(
                id: footprint.id,
                featureType: "footprint",
                geometry: polygonGeometry(footprint.coordinates),
                properties: compact([
                    "building_id": building.id.uuidString
                ])
            )
        }
    }

    private func levelFeatures() -> [[String: Any]] {
        venue.buildings.flatMap { building in
            building.levels.map { level in
                feature(
                    id: level.id,
                    featureType: "level",
                    geometry: NSNull(),
                    properties: compact([
                        "name": localized(level.name),
                        "short_name": localized(level.shortName),
                        "ordinal": level.ordinal,
                        "building_id": building.id.uuidString
                    ])
                )
            }
        }
    }

    private func unitFeatures() -> [[String: Any]] {
        venue.buildings.flatMap { building in
            building.levels.flatMap { level in
                level.units.map { unit in
                    feature(
                        id: unit.id,
                        featureType: "unit",
                        geometry: polygonGeometry(unit.coordinates),
                        properties: compact([
                            "category": unit.category.rawValue,
                            "name": localized(unit.name),
                            "level_id": level.id.uuidString,
                            "building_id": building.id.uuidString,
                            "display_point": displayPoint(for: unit.coordinates)
                        ])
                    )
                }
            }
        }
    }

    private func openingFeatures() -> [[String: Any]] {
        venue.buildings.flatMap { building in
            building.levels.flatMap { level in
                level.openings.map { opening in
                    feature(
                        id: opening.id,
                        featureType: "opening",
                        geometry: lineGeometry(opening.coordinates),
                        properties: compact([
                            "category": opening.category.rawValue,
                            "access_control": opening.accessControl?.rawValue,
                            "level_id": level.id.uuidString,
                            "building_id": building.id.uuidString
                        ])
                    )
                }
            }
        }
    }

    private func amenityFeatures() -> [[String: Any]] {
        venue.buildings.flatMap { building in
            building.levels.flatMap { level in
                level.units.flatMap { unit in
                    unit.amenities.map { amenity in
                        feature(
                            id: amenity.id,
                            featureType: "amenity",
                            geometry: pointGeometry(amenity.coordinate),
                            properties: compact([
                                "category": amenity.category.rawValue,
                                "name": localized(amenity.name),
                                "unit_id": unit.id.uuidString,
                                "level_id": level.id.uuidString,
                                "building_id": building.id.uuidString
                            ])
                        )
                    }
                }
            }
        }
    }

    private func occupantFeatures() -> [[String: Any]] {
        venue.buildings.flatMap { building in
            building.levels.flatMap { level in
                level.units.flatMap { unit in
                    unit.occupants.map { occupant in
                        feature(
                            id: occupant.id,
                            featureType: "occupant",
                            geometry: NSNull(),
                            properties: compact([
                                "name": localized(occupant.name),
                                "category": occupant.category?.rawValue,
                                "phone": occupant.phone,
                                "website": occupant.website?.absoluteString,
                                "hours": occupant.hours,
                                "unit_id": unit.id.uuidString,
                                "level_id": level.id.uuidString,
                                "building_id": building.id.uuidString
                            ])
                        )
                    }
                }
            }
        }
    }

    private func feature(
        id: UUID,
        featureType: String,
        geometry: Any,
        properties: [String: Any]
    ) -> [String: Any] {
        [
            "id": id.uuidString,
            "type": "Feature",
            "feature_type": featureType,
            "geometry": geometry,
            "properties": properties
        ]
    }

    private func polygonGeometry(_ coordinates: [Coordinate]) -> [String: Any] {
        [
            "type": "Polygon",
            "coordinates": [closedRing(coordinates).map(position)]
        ]
    }

    private func lineGeometry(_ coordinates: [Coordinate]) -> [String: Any] {
        [
            "type": "LineString",
            "coordinates": coordinates.map(position)
        ]
    }

    private func pointGeometry(_ coordinate: Coordinate?) -> Any {
        guard let coordinate else { return NSNull() }
        return [
            "type": "Point",
            "coordinates": position(coordinate)
        ]
    }

    private func displayPoint(for coordinates: [Coordinate]) -> [String: Any]? {
        guard !coordinates.isEmpty else { return nil }
        let latitude = coordinates.map(\.latitude).reduce(0, +) / Double(coordinates.count)
        let longitude = coordinates.map(\.longitude).reduce(0, +) / Double(coordinates.count)

        return [
            "type": "Point",
            "coordinates": [longitude, latitude]
        ]
    }

    private func closedRing(_ coordinates: [Coordinate]) -> [Coordinate] {
        guard let first = coordinates.first, let last = coordinates.last else { return coordinates }
        guard first != last else { return coordinates }
        return coordinates + [first]
    }

    private func position(_ coordinate: Coordinate) -> [Double] {
        [coordinate.longitude, coordinate.latitude]
    }

    private func localized(_ value: String?) -> [String: String]? {
        guard let value, !value.isEmpty else { return nil }
        return ["ko": value]
    }

    private func compact(_ values: [String: Any?]) -> [String: Any] {
        values.reduce(into: [:]) { result, pair in
            if let value = pair.value {
                result[pair.key] = value
            }
        }
    }
}

private struct ZipArchiveWriter {
    let files: [String: Data]

    func makeArchive() throws -> Data {
        var archive = Data()
        var centralDirectory = Data()

        for (name, data) in files.sorted(by: { $0.key < $1.key }) {
            let offset = UInt32(archive.count)
            let nameData = Data(name.utf8)
            let checksum = CRC32.checksum(data)

            archive.appendUInt32LE(0x04034b50)
            archive.appendUInt16LE(20)
            archive.appendUInt16LE(0)
            archive.appendUInt16LE(0)
            archive.appendUInt16LE(0)
            archive.appendUInt16LE(0)
            archive.appendUInt32LE(checksum)
            archive.appendUInt32LE(UInt32(data.count))
            archive.appendUInt32LE(UInt32(data.count))
            archive.appendUInt16LE(UInt16(nameData.count))
            archive.appendUInt16LE(0)
            archive.append(nameData)
            archive.append(data)

            centralDirectory.appendUInt32LE(0x02014b50)
            centralDirectory.appendUInt16LE(20)
            centralDirectory.appendUInt16LE(20)
            centralDirectory.appendUInt16LE(0)
            centralDirectory.appendUInt16LE(0)
            centralDirectory.appendUInt16LE(0)
            centralDirectory.appendUInt16LE(0)
            centralDirectory.appendUInt32LE(checksum)
            centralDirectory.appendUInt32LE(UInt32(data.count))
            centralDirectory.appendUInt32LE(UInt32(data.count))
            centralDirectory.appendUInt16LE(UInt16(nameData.count))
            centralDirectory.appendUInt16LE(0)
            centralDirectory.appendUInt16LE(0)
            centralDirectory.appendUInt16LE(0)
            centralDirectory.appendUInt16LE(0)
            centralDirectory.appendUInt32LE(0)
            centralDirectory.appendUInt32LE(offset)
            centralDirectory.append(nameData)
        }

        let centralDirectoryOffset = UInt32(archive.count)
        archive.append(centralDirectory)

        archive.appendUInt32LE(0x06054b50)
        archive.appendUInt16LE(0)
        archive.appendUInt16LE(0)
        archive.appendUInt16LE(UInt16(files.count))
        archive.appendUInt16LE(UInt16(files.count))
        archive.appendUInt32LE(UInt32(centralDirectory.count))
        archive.appendUInt32LE(centralDirectoryOffset)
        archive.appendUInt16LE(0)

        return archive
    }
}

private enum CRC32 {
    static func checksum(_ data: Data) -> UInt32 {
        var crc: UInt32 = 0xffff_ffff

        for byte in data {
            crc ^= UInt32(byte)

            for _ in 0..<8 {
                if crc & 1 == 1 {
                    crc = (crc >> 1) ^ 0xedb8_8320
                } else {
                    crc >>= 1
                }
            }
        }

        return crc ^ 0xffff_ffff
    }
}

private extension Data {
    mutating func appendUInt16LE(_ value: UInt16) {
        append(UInt8(value & 0x00ff))
        append(UInt8((value >> 8) & 0x00ff))
    }

    mutating func appendUInt32LE(_ value: UInt32) {
        append(UInt8(value & 0x0000_00ff))
        append(UInt8((value >> 8) & 0x0000_00ff))
        append(UInt8((value >> 16) & 0x0000_00ff))
        append(UInt8((value >> 24) & 0x0000_00ff))
    }
}
