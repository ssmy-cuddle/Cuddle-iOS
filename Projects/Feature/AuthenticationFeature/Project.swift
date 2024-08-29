import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.feature(
    name: "AuthenticationFeature",
    bundleID: "AuthenticationFeature",
    targets: [.interface, .staticFramework, .testing, .example, .tests],
    dependencies: [
        Core.appResource.targetDependency,
        Core.designSystem.targetDependency,
        Feature.base.targetDependency,
        External.composableArchitecture.targetDependency
    ]
)
