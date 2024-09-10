import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.client(
    name: "OriginalClient",
    bundleID: "OriginalClient",
    targets: [.staticFramework, .tests],
    dependencies: [
        Client.base.targetDependency,
        External.composableArchitecture.targetDependency
    ]
)
