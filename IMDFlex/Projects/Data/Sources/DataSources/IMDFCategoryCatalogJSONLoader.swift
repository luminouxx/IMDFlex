import Foundation
import Domain

public final class IMDFCategoryCatalogJSONLoader: IMDFCategoryCatalogLoading, Sendable {
    private let resourceName: String
    private let bundle: Bundle
    private let decoder: JSONDecoder

    public init(
        resourceName: String = "IMDFCategoryCatalog.generated",
        bundle: Bundle? = nil,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.resourceName = resourceName
        self.bundle = bundle ?? .imdfCategoryCatalogResources
        self.decoder = decoder
    }

    public func loadCatalog() async throws -> IMDFCategoryCatalog {
        guard let url = bundle.url(forResource: resourceName, withExtension: "json") else {
            throw IMDFCategoryCatalogLoadingError.resourceNotFound(resourceName: resourceName)
        }

        let data = try Data(contentsOf: url)
        return try decoder.decode(IMDFCategoryCatalog.self, from: data)
    }
}

public enum IMDFCategoryCatalogLoadingError: Error, Equatable, Sendable {
    case resourceNotFound(resourceName: String)
}

private final class IMDFCategoryCatalogBundleToken {}

private extension Bundle {
    static var imdfCategoryCatalogResources: Bundle {
        Bundle(for: IMDFCategoryCatalogBundleToken.self)
    }
}
