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
            dependencies: [
                .project(target: "AppResource", path: "../Core/AppResource"),
                .project(target: "DesignSystem", path: "../Core/DesignSystem"),
                .external(name: "ComposableArchitecture")
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

