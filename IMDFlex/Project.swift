import ProjectDescription

let project = Project(
    name: "IMDFlex",
    targets: [
        .target(
            name: "IMDFlex",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.IMDFlex",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "IMDFlex/Sources",
                "IMDFlex/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "IMDFlexTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.IMDFlexTests",
            infoPlist: .default,
            buildableFolders: [
                "IMDFlex/Tests"
            ],
            dependencies: [.target(name: "IMDFlex")]
        ),
    ]
)
