import Foundation
import XCTest
@testable import Data
import Domain

final class IMDFCategoryCatalogJSONLoaderTests: XCTestCase {
    func test_whenGeneratedCatalogIsLoaded_thenItMatchesOfficialFeatureCounts() async throws {
        // Given
        let sut = makeSUT()

        // When
        let catalog = try await sut.loadCatalog()
        let countsByFeature = Dictionary(
            uniqueKeysWithValues: IMDFCategoryFeature.allCases.map { feature in
                (feature, catalog.entries(for: feature).count)
            }
        )

        // Then
        for summary in IMDFCategoryCatalogSource.appleCategories20210728FeatureSummaries {
            XCTAssertEqual(countsByFeature[summary.feature], summary.categoryCount, "Unexpected count for \(summary.feature.rawValue)")
        }
    }

    func test_whenGeneratedCatalogIsLoaded_thenItContainsRepresentativeRawValues() async throws {
        // Given
        let sut = makeSUT()

        // When
        let catalog = try await sut.loadCatalog()

        // Then
        XCTAssertTrue(catalog.contains("shoppingcenter", for: .venue))
        XCTAssertTrue(catalog.contains("drinkingfountain", for: .amenity))
        XCTAssertTrue(catalog.contains("corporateoffices", for: .occupant))
        XCTAssertTrue(catalog.contains("traversal.path", for: .relationship))
        XCTAssertTrue(catalog.contains("gatearea", for: .section))
    }

    func test_whenGeneratedCatalogIsLoaded_thenDefinitionsArePreservedWhenAvailable() async throws {
        // Given
        let sut = makeSUT()

        // When
        let catalog = try await sut.loadCatalog()
        let accessibilityEntry = try XCTUnwrap(
            catalog.entries(for: .accessibility).first { $0.value == "braille" }
        )

        // Then
        XCTAssertFalse(accessibilityEntry.definition?.isEmpty ?? true)
    }

    func test_whenResourceIsMissing_thenLoaderThrowsResourceNotFound() async throws {
        // Given
        let sut = makeSUT(resourceName: "MissingIMDFCategoryCatalog")

        // When
        do {
            _ = try await sut.loadCatalog()
            XCTFail("Expected resourceNotFound error.")
        } catch let error as IMDFCategoryCatalogLoadingError {
            // Then
            XCTAssertEqual(error, .resourceNotFound(resourceName: "MissingIMDFCategoryCatalog"))
        } catch {
            XCTFail("Expected IMDFCategoryCatalogLoadingError, got \(error).")
        }
    }

    private func makeSUT(resourceName: String = "IMDFCategoryCatalog.generated") -> IMDFCategoryCatalogJSONLoader {
        IMDFCategoryCatalogJSONLoader(resourceName: resourceName)
    }
}
