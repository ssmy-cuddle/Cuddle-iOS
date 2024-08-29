import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.domain(
    name: "BaseDomain",
    bundleID: "BaseDomain",
    targets: [.staticFramework, .tests]
)
