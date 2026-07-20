import XCTest
@testable import Domain

final class IMDFCategoryCatalogTests: XCTestCase {
    func test_whenAppleCategorySummariesAreLoaded_thenTheyMatchOfficialFeatureCounts() {
        // Given
        let summaries = IMDFCategoryCatalogSource.appleCategories20210728FeatureSummaries

        // When
        let countsByFeature = Dictionary(uniqueKeysWithValues: summaries.map { ($0.feature, $0.categoryCount) })

        // Then
        XCTAssertEqual(countsByFeature[.accessControl], 8)
        XCTAssertEqual(countsByFeature[.accessibility], 10)
        XCTAssertEqual(countsByFeature[.amenity], 172)
        XCTAssertEqual(countsByFeature[.building], 5)
        XCTAssertEqual(countsByFeature[.door], 11)
        XCTAssertEqual(countsByFeature[.doorMaterial], 4)
        XCTAssertEqual(countsByFeature[.fixture], 15)
        XCTAssertEqual(countsByFeature[.footprint], 3)
        XCTAssertEqual(countsByFeature[.geofence], 8)
        XCTAssertEqual(countsByFeature[.level], 9)
        XCTAssertEqual(countsByFeature[.occupant], 1116)
        XCTAssertEqual(countsByFeature[.opening], 7)
        XCTAssertEqual(countsByFeature[.relationship], 7)
        XCTAssertEqual(countsByFeature[.restriction], 2)
        XCTAssertEqual(countsByFeature[.section], 71)
        XCTAssertEqual(countsByFeature[.unit], 63)
        XCTAssertEqual(countsByFeature[.venue], 22)
    }

    func test_whenRepresentativeValuesAreLoaded_thenTheyContainAppleRawCategoryValues() throws {
        // Given
        let summaries = IMDFCategoryCatalogSource.appleCategories20210728FeatureSummaries

        // When
        let amenity = try XCTUnwrap(summaries.first { $0.feature == .amenity })
        let occupant = try XCTUnwrap(summaries.first { $0.feature == .occupant })
        let section = try XCTUnwrap(summaries.first { $0.feature == .section })
        let unit = try XCTUnwrap(summaries.first { $0.feature == .unit })

        // Then
        XCTAssertTrue(amenity.representativeValues.contains("drinkingfountain"))
        XCTAssertTrue(occupant.representativeValues.contains("corporateoffices"))
        XCTAssertTrue(section.representativeValues.contains("gatearea"))
        XCTAssertTrue(unit.representativeValues.contains("foodservice"))
    }

    func test_whenCatalogContainsEntry_thenLookupUsesFeatureAndRawValue() {
        // Given
        let sut = IMDFCategoryCatalog(entries: [
            .init(feature: .venue, value: "shoppingcenter"),
            .init(feature: .unit, value: "walkway")
        ])

        // When
        let venueEntries = sut.entries(for: .venue)

        // Then
        XCTAssertEqual(venueEntries, [.init(feature: .venue, value: "shoppingcenter")])
        XCTAssertTrue(sut.contains("shoppingcenter", for: .venue))
        XCTAssertFalse(sut.contains("shoppingcenter", for: .unit))
    }
}
