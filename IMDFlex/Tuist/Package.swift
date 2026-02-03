// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [:]
    )
#endif

let package = Package(
    name: "IMDFlex",
    dependencies: [
        // 추후 SPM 의존성 추가 예정
    ]
)
