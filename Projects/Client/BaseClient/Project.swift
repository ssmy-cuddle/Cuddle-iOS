import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.client(
    name: "BaseClient",
    bundleID: "BaseClient",
    targets: [.staticFramework, .tests]
)
