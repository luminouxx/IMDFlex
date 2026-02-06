import ProjectDescription

public enum AppConstants {
    public static let appName = "IMDFlex"
    public static let bundleIdPrefix = "com.luminoux.imdflex"
    public static let deploymentTarget: DeploymentTargets = .iOS("18.0")
    public static let destinations: Destinations = .iOS
    
    public enum Version {
        public static let app = "1.0.0"
        public static let build = "1"
    }
}

// MARK: - Bundle ID
public extension AppConstants {
    static func bundleId(for module: String) -> String {
        "\(bundleIdPrefix).\(module.lowercased())"
    }
    
    static var appBundleId: String {
        bundleIdPrefix
    }
}
