import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: "Data",
    dependencies: [
        .project(target: "Domain", path: "../Domain"),
    ]
)
