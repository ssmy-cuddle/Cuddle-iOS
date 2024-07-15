//
//  AppCoordinator.swift
//  AppResourceManifests
//
//  Created by mvldev7 on 7/9/24.
//

import ProjectDescription
import DependencyPlugin

let project = Project(
    name: "AuthenticationCoordinator",
    targets: [
        .target(
            name: "AuthenticationCoordinatorInferface",
            destinations: .iOS,
            product: .staticLibrary,
            bundleId: "",
            infoPlist: .default,
            sources: ["Interface/Sources/**"],
            dependencies: [
                External.composableArchitecture.targetDependency,
                External.tcaCoordinators.targetDependency
            ]
        ),
        .target(
            name: "AuthenticationCoordinator",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.ssmy.cuddle",
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [""],
            dependencies: [
                .target(name: "AuthenticationCoordinatorInferface"),
                External.composableArchitecture.targetDependency,
                External.tcaCoordinators.targetDependency
            ]
        )
    ]
)
