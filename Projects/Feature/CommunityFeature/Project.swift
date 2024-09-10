import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.feature(
    name: "CommunityFeature",
    bundleID: "CommunityFeature",
    targets: [.interface, .staticFramework, .testing, .example, .tests],
    dependencies: [
        Core.appResource.targetDependency,
        Core.designSystem.targetDependency,
        Core.uiComponent.targetDependency,
        Feature.base.targetDependency,
        Feature.home.targetDependency,
        Client.community.targetDependency,
        External.composableArchitecture.targetDependency,
    ]
)
