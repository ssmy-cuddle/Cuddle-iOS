import ProjectDescription

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
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
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

