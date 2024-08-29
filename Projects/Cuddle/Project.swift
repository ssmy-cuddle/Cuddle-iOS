import ProjectDescription
import DependencyPlugin

let coreDependencies: [TargetDependency] = Core.allCases.map(\.targetDependency)
let featureDependencies: [TargetDependency] = Feature.allCases.map(\.targetDependency)
let domainDependencies: [TargetDependency] = Domain.allCases.map(\.targetDependency)
let externalDependencies: [TargetDependency] = External.allCases.map(\.targetDependency)

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
            dependencies: coreDependencies + featureDependencies + domainDependencies + externalDependencies
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

