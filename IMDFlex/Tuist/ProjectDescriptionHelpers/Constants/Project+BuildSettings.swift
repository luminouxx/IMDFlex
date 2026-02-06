import ProjectDescription

public enum BuildSettings {
    
    public static let swiftVersion: Settings = .settings(
        base: [
            "SWIFT_VERSION": "6.0"
        ]
    )
    
    public static let debug: Settings = .settings(
        base: [
            "SWIFT_VERSION": "6.0",
            "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
            "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
            "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "DEBUG",
        ],
        configurations: [
            .debug(name: "Debug")
        ]
    )
    
    public static let release: Settings = .settings(
        base: [
            "SWIFT_VERSION": "6.0",
            "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
            "SWIFT_OPTIMIZATION_LEVEL": "-O",
            "SWIFT_COMPILATION_MODE": "wholemodule",
        ],
        configurations: [
            .release(name: "Release")
        ]
    )
    
    // MARK: - All Configurations
    
    public static let `default`: Settings = .settings(
        base: [
            "SWIFT_VERSION": "6.0",
        ],
        configurations: [
            .debug(name: "Debug", settings: [
                "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
                "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "DEBUG",
            ]),
            .release(name: "Release", settings: [
                "SWIFT_OPTIMIZATION_LEVEL": "-O",
                "SWIFT_COMPILATION_MODE": "wholemodule",
            ])
        ]
    )
    
    // MARK: - Framework Specific
    
    public static let framework: Settings = .settings(
        base: [
            "SWIFT_VERSION": "6.0",
            "BUILD_LIBRARY_FOR_DISTRIBUTION": "NO",
        ],
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ]
    )
}
