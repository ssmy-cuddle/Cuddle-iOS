import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.feature(
    name: "BaseFeature",
    bundleID: "BaseFeature",
    targets: [.interface, .staticFramework, .testing, .example, .tests],
    dependencies: []
)
