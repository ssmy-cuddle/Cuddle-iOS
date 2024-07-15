import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "Cuddle",
    targets: [
        .target(
            name: "Cuddle",
            destinations: .iOS,
            product: .app,
            bundleId: "com.ssmy.cuddle",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "white",
                        "UIImageName": "cuddle-launch",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: Core.allCases.map(\.targetDependency) +
            External.allCases.map(\.targetDependency) +
            [Feature.authentification.targetDependency] +
            [
                TargetDependency.project(
                    target: "AuthenticationCoordinator",
                    path: .relativeToRoot("Projects/Coordinator/AuthenticationCoordinator")
                )
            ]
        ),
        .target(
            name: "CuddleTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.ssmy.cuddleTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "Cuddle")]
        )
    ]
)

