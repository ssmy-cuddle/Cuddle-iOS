import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.feature(
    name: "BaseFeature",
    bundleID: "BaseFeature",
    targets: [.interface, .staticFramework, .testing, .example, .tests],
    dependencies: [
        Client.base.targetDependency,
        External.composableArchitecture.targetDependency,
        External.popupView.targetDependency
    ]
)
