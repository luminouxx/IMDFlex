import Foundation

final class PresentationBundleToken {}

extension Bundle {
    static let imdfPresentation = Bundle(for: PresentationBundleToken.self)
}
