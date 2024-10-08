import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.feature(
    name: "ProfileFeature",
    bundleID: "ProfileFeature",
    targets: [.interface, .staticFramework, .testing, .example, .tests],
    dependencies: [
        Core.appResource.targetDependency,
        Core.designSystem.targetDependency,
        Core.uiComponent.targetDependency,
        Feature.base.targetDependency,
        External.composableArchitecture.targetDependency,
        External.kingfisher.targetDependency,
        External.navigationTransitions.targetDependency
    ],
    interfaceDependencies: [
        Client.profile.targetDependency
    ]
)
