import ProjectDescription

// MARK: - InfoPlist Keys

public enum InfoPlistKey {
    
    // MARK: - App Display
    
    public static let launchScreen: [String: Plist.Value] = [
        "UILaunchScreen": [:]
    ]
    
    public static func displayName(_ name: String) -> [String: Plist.Value] {
        ["CFBundleDisplayName": .string(name)]
    }
    
    // MARK: - Permissions
    
    public enum Permission {
        public static let locationWhenInUse: [String: Plist.Value] = [
            "NSLocationWhenInUseUsageDescription": "We need your location to create accurate indoor maps"
        ]
        
        public static let locationAlways: [String: Plist.Value] = [
            "NSLocationAlwaysAndWhenInUseUsageDescription": "We need your location to create accurate indoor maps"
        ]
        
        public static let camera: [String: Plist.Value] = [
            "NSCameraUsageDescription": "We need camera access to capture floor plans"
        ]
        
        public static let photoLibrary: [String: Plist.Value] = [
            "NSPhotoLibraryUsageDescription": "We need photo library access to import floor plan images"
        ]
        
        public static let fileAccess: [String: Plist.Value] = [
            "UIFileSharingEnabled": true,
            "LSSupportsOpeningDocumentsInPlace": true
        ]
    }
    
    // MARK: - App Transport Security
    
    public enum Network {
        public static let allowArbitraryLoads: [String: Plist.Value] = [
            "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true]
        ]
    }
}

// MARK: - InfoPlist Builder

public struct InfoPlistBuilder {
    private var entries: [String: Plist.Value] = [:]
    
    public init() {}
    
    public mutating func add(_ dict: [String: Plist.Value]) {
        entries.merge(dict) { _, new in new }
    }
    
    public func build() -> [String: Plist.Value] {
        entries
    }
}

public extension InfoPlistBuilder {
    static func app(displayName: String = AppConstants.appName) -> [String: Plist.Value] {
        var builder = InfoPlistBuilder()
        builder.add(InfoPlistKey.launchScreen)
        builder.add(InfoPlistKey.displayName(displayName))
        builder.add(InfoPlistKey.Permission.locationWhenInUse)
        return builder.build()
    }
}
