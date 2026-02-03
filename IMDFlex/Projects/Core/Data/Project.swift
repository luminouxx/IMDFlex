import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Data",
    dependencies: [
        .project(target: "Domain", path: "../Domain"),
    ]
)
