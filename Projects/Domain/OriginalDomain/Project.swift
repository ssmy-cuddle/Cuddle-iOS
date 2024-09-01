import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.domain(
    name: "OriginalDomain",
    bundleID: "OriginalDomain",
    targets: [.staticFramework, .tests],
    dependencies: [
        Domain.base.targetDependency
    ]
)
