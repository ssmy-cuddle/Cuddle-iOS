import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.client(
    name: "AuthenticationClient",
    bundleID: "AuthenticationClient",
    targets: [.staticFramework, .tests],
    dependencies: [
        Client.base.targetDependency,
        External.composableArchitecture.targetDependency
    ]
)
