import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.domain(
    name: "ProfileDomain",
    bundleID: "ProfileDomain",
    targets: [.staticFramework, .tests],
    dependencies: [
        Domain.base.targetDependency
    ]
)
