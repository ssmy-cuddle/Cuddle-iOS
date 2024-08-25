import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "UIComponent",
    targets: [
        .target(
            name: "UIComponent",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.ssmy.cuddle",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "AppResource", path: "../AppResource"),
                .project(target: "DesignSystem", path: "../DesignSystem")
            ]
        )
    ]
)
