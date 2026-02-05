import ProjectDescription

let project = Project(
    name: "IMDFlex",
    targets: [
        .target(
            name: "IMDFlex",
            destinations: .iOS,
            product: .app,
            bundleId: "com.luminoux.imdflex",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [:],
                "CFBundleDisplayName": "IMDFlex",
                "NSLocationWhenInUseUsageDescription": "실내 지도 생성을 위해 위치 정보가 필요합니다",
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Data", path: "../Data"),
                .project(target: "Presentation", path: "../Presentation"),
                .project(target: "DesignSystem", path: "../DesignSystem"),
            ]
        ),
        .target(
            name: "IMDFlexTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.luminoux.imdflex.tests",
            deploymentTargets: .iOS("18.0"),
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "IMDFlex"),
            ]
        )
    ]
)
