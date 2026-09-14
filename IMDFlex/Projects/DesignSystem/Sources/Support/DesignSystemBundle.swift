import Foundation

final class DesignSystemBundleToken {}

extension Bundle {
    static let imdfDesignSystem = Bundle(for: DesignSystemBundleToken.self)
}
