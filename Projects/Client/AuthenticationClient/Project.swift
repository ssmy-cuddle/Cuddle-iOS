import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.client(
    name: "AuthenticationClient",
    bundleID: "AuthenticationClient",
    targets: [.staticFramework, .live, .tests],
    dependencies: [
        Core.networking.targetDependency,
        Client.base.targetDependency,
        External.composableArchitecture.targetDependency
    ]
)
