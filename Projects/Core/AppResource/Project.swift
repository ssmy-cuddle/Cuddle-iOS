//
//  Project.swift
//  Config
//
//  Created by mvldev7 on 7/6/24.
//

import ProjectDescription

let project = Project(
    name: "AppResource",
    targets: [
        .target(
            name: "AppResource",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.ssmy.cuddle",
            infoPlist: .extendingDefault(
                with: [
                    "UIAppFonts": [
                        "Pretendard-SemiBold.ttf",
                        "Pretendard-Bold.ttf",
                        "Pretendard-Medium.ttf",
                        "NPS-font-Extrabold.ttf",
                        "NPS-font-Bold.ttf",
                        "NPS-font-Regular.ttf"
                    ]
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        )
    ]
)
