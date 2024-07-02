import ProjectDescription

let project = Project(
    name: "cuddle",
    targets: [
        .target(
            name: "cuddle",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.cuddle",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["cuddle/Sources/**"],
            resources: ["cuddle/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "cuddleTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.cuddleTests",
            infoPlist: .default,
            sources: ["cuddle/Tests/**"],
            resources: [],
            dependencies: [.target(name: "cuddle")]
        )
    ]
)
