import ProjectDescription

public extension Project {
    
    static func framework(
        name: String,
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil,
        hasTests: Bool = true
    ) -> Project {
        var targets: [Target] = [
            .target(
                name: name,
                destinations: .iOS,
                product: .framework,
                bundleId: "com.luminoux.imdflex.\(name.lowercased())",
                deploymentTargets: .iOS("18.0"),
                sources: ["Sources/**"],
                resources: resources,
                dependencies: dependencies
            )
        ]
        
        if hasTests {
            targets.append(
                .target(
                    name: "\(name)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "com.luminoux.imdflex.\(name.lowercased()).tests",
                    deploymentTargets: .iOS("18.0"),
                    sources: ["Tests/**"],
                    dependencies: [.target(name: name)]
                )
            )
        }
        
        return Project(
            name: name,
            targets: targets
        )
    }
    
    static func feature(
        name: String,
        additionalDependencies: [TargetDependency] = []
    ) -> Project {
        let baseDependencies: [TargetDependency] = [
            .project(target: "Domain", path: "../../Core/Domain"),
            .project(target: "Data", path: "../../Core/Data"),
            .project(target: "MapEditor", path: "../../Core/MapEditor"),
            .project(target: "DesignSystem", path: "../../Core/DesignSystem"),
        ]
        
        return .framework(
            name: name,
            dependencies: baseDependencies + additionalDependencies
        )
    }
}
