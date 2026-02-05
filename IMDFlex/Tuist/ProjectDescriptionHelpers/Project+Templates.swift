import ProjectDescription

public extension Project {
    
    static func module(
        name: String,
        product: Product = .framework,
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil,
        hasTests: Bool = true
    ) -> Project {
        var targets: [Target] = [
            .target(
                name: name,
                destinations: .iOS,
                product: product,
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
}
