//
//  Project.swift
//  CuddleManifests
//
//  Created by mvldev7 on 7/3/24.
//

import ProjectDescription

let project = Project(
    name: "DesignSystem",
    targets: [
        .target(
            name: "DesignSystem",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.ssmy.cuddle",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "AppResource", path: "../AppResource")
            ]
        )
    ]
)
