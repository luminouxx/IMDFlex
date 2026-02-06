import ProjectDescription


public extension Project {
    
    // MARK: - Framework Module
    
    /// Creates a framework module with optional tests
    static func module(
        module: Module,
        product: Product = .framework,
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil,
        hasTests: Bool = true,
        additionalFiles: [FileElement] = []
    ) -> Project {
        var targets: [Target] = [
            .target(
                name: module.name,
                destinations: AppConstants.destinations,
                product: product,
                bundleId: AppConstants.bundleId(for: module.name),
                deploymentTargets: AppConstants.deploymentTarget,
                sources: ["Sources/**"],
                resources: resources,
                dependencies: dependencies,
                settings: BuildSettings.framework
            )
        ]
        
        if hasTests {
            targets.append(
                .target(
                    name: "\(module.name)Tests",
                    destinations: AppConstants.destinations,
                    product: .unitTests,
                    bundleId: AppConstants.bundleId(for: "\(module.name).tests"),
                    deploymentTargets: AppConstants.deploymentTarget,
                    sources: ["Tests/**"],
                    dependencies: [.target(name: module.name)]
                )
            )
        }
        
        var files: [FileElement] = ["README.md"]
        files.append(contentsOf: additionalFiles)
        
        return Project(
            name: module.name,
            settings: BuildSettings.default,
            targets: targets,
            additionalFiles: files
        )
    }
    
    // MARK: - App Module
    
    /// Creates the main app target with all module dependencies
    static func app(
        name: String = AppConstants.appName,
        infoPlist: [String: Plist.Value] = InfoPlistBuilder.app(),
        dependencies: [TargetDependency] = .allModules,
        hasTests: Bool = true,
        additionalFiles: [FileElement] = []
    ) -> Project {
        var targets: [Target] = [
            .target(
                name: name,
                destinations: AppConstants.destinations,
                product: .app,
                bundleId: AppConstants.appBundleId,
                deploymentTargets: AppConstants.deploymentTarget,
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                dependencies: dependencies,
                settings: BuildSettings.default
            )
        ]
        
        if hasTests {
            targets.append(
                .target(
                    name: "\(name)Tests",
                    destinations: AppConstants.destinations,
                    product: .unitTests,
                    bundleId: AppConstants.bundleId(for: "tests"),
                    deploymentTargets: AppConstants.deploymentTarget,
                    sources: ["Tests/**"],
                    dependencies: [.target(name: name)]
                )
            )
        }
        
        var files: [FileElement] = ["README.md"]
        files.append(contentsOf: additionalFiles)
        
        return Project(
            name: name,
            settings: BuildSettings.default,
            targets: targets,
            additionalFiles: files
        )
    }
}
