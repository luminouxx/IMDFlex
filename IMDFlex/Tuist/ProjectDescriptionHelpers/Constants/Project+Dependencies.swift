import ProjectDescription

public enum Module: String, CaseIterable {
    case domain = "Domain"
    case data = "Data"
    case presentation = "Presentation"
    case designSystem = "DesignSystem"
    
    public var name: String { rawValue }
    
    /// Return Absolute Path (for Workspace.swift)
    public var absolutePath: Path {
        "Project/\(name)"
    }
    
    /// Return Relative Path
    public var relativePath: Path {
        "../\(name)"
    }
    
    public var dependency: TargetDependency {
        .project(target: name, path: relativePath)
    }
}

public extension TargetDependency {
    static let domain: TargetDependency = Module.domain.dependency
    static let data: TargetDependency = Module.data.dependency
    static let presentation: TargetDependency = Module.presentation.dependency
    static let designSystem: TargetDependency = Module.designSystem.dependency
}

// MARK: - Dependency Groups

public extension Array where Element == TargetDependency {
    /// All core modules for App target
    static let allModules: [TargetDependency] = [
        .domain,
        .data,
        .presentation,
        .designSystem,
    ]
    
    /// Dependencies for Presentation module
    static let presentationDependencies: [TargetDependency] = [
        .domain,
        .designSystem,
    ]
    
    /// Dependencies for Data module
    static let dataDependencies: [TargetDependency] = [
        .domain,
    ]
}

public extension Array where Element == Path {
    /// Used in Workspace.swift
    static let allProjectPaths: [Path] = [
        "Projects/App"
    ] + Module.allCases.map(\.absolutePath)
}
