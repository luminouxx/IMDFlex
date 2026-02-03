import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "MapEditor",
    dependencies: [
        .project(target: "Domain", path: "../Domain"),
        .project(target: "DesignSystem", path: "../DesignSystem"),
    ]
)
