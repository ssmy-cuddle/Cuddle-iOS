import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.client(
    name: "CommunityClient",
    bundleID: "CommunityClient",
    targets: [.staticFramework, .tests],
    dependencies: [
        Client.base.targetDependency,
        External.composableArchitecture.targetDependency
    ]
)
