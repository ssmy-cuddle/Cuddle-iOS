import ProjectDescription
import DependencyPlugin

let coreDependencies: [TargetDependency] = Core.allCases.map(\.targetDependency)
let featureDependencies: [TargetDependency] = Feature.allCases.map(\.targetDependency)
let clientDependencies: [TargetDependency] = Client.allCases.map(\.targetDependency)
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
                    "UIUserInterfaceStyle": "Light",
                    "LSApplicationQueriesSchemes": [
                        "kakaokompassauth"
                    ],
                    "CFBundleURLTypes": [
                        [
                            "CFBundleURLName": "kakao",
                            "CFBundleURLSchemes": [
                                "kakao5696c6073e2f06e25991cae9556fc0bb"
                            ]
                        ]
                    ],
                    "KAKAO_APP_KEY": "5696c6073e2f06e25991cae9556fc0bb"
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: .file(path: .relativeToRoot("Projects/Cuddle/Cuddle.entitlements")),
            dependencies: coreDependencies + featureDependencies + clientDependencies + externalDependencies
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

