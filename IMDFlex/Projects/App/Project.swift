import ProjectDescription

let project = Project(
    name: "IMDFlex",
    targets: [
        .target(
            name: "IMDFlex",
            destinations: .iOS,
            product: .app,
            bundleId: "com.luminoux.IMDFlex",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [:],
                "CFBundleDisplayName": "IMDF Flex",
                "NSLocationWhenInUseUsageDescription": "We need your location to create accurate indoor maps",
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Core/Domain"),
                .project(target: "Data", path: "../Core/Data"),
                .project(target: "MapEditor", path: "../Core/MapEditor"),
                .project(target: "DesignSystem", path: "../Core/DesignSystem"),
                .project(target: "VenueFeature", path: "../Features/Venue"),
                .project(target: "BuildingFeature", path: "../Features/Building"),
                .project(target: "FootprintFeature", path: "../Features/Footprint"),
                .project(target: "LevelFeature", path: "../Features/Level"),
                .project(target: "UnitFeature", path: "../Features/Unit"),
                .project(target: "OpeningFeature", path: "../Features/Opening"),
                .project(target: "AmenityFeature", path: "../Features/Amenity"),
                .project(target: "OccupantFeature", path: "../Features/Occupant"),
                .project(target: "AddressFeature", path: "../Features/Address"),
                .project(target: "ProjectFeature", path: "../Features/Project"),
                .project(target: "Extensions", path: "../Shared/Extensions"),
                .project(target: "Utils", path: "../Shared/Utils"),
            ]
        ),
        .target(
            name: "IMDFlexTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.luminoux.IMDFlex.tests",
            deploymentTargets: .iOS("18.0"),
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "IMDFlex"),
            ]
        )
    ]
)
