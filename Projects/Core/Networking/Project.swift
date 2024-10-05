import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project = Project(
    name: "Networking",
    targets: [
        .target(
            name: "Networking",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.ssmy.cuddle",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                External.composableArchitecture.targetDependency,
                External.alamofire.targetDependency
            ]
        )
    ]
)
