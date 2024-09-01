import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.feature(
    name: "HomeFeature",
    bundleID: "HomeFeature",
    targets: [.interface, .staticFramework, .testing, .example, .tests],
    dependencies: [
        Core.appResource.targetDependency,
        Core.designSystem.targetDependency,
        Core.uiComponent.targetDependency,
        Feature.base.targetDependency,
        Domain.original.targetDependency,
        External.composableArchitecture.targetDependency,
        External.kingfisher.targetDependency
    ]
)
