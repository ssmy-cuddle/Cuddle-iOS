import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.client(
    name: "ProfileClient",
    bundleID: "ProfileClient",
    targets: [.staticFramework, .tests],
    dependencies: [
        Client.base.targetDependency,
        External.composableArchitecture.targetDependency
    ]
)
