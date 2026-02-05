import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: "Presentation",
    dependencies: [
        .project(target: "Domain", path: "../Domain"),
        .project(target: "DesignSystem", path: "../DesignSystem"),
    ]
)
