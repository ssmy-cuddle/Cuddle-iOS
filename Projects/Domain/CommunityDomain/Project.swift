import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project.domain(
    name: "CommunityDomain",
    bundleID: "CommunityDomain",
    targets: [.staticFramework, .tests],
    dependencies: [
        Domain.base.targetDependency
    ]
)
