//
//  Project+Client.swift
//  AppResourceManifests
//
//  Created by mvldev7 on 7/6/24.
//

import ProjectDescription

public extension Project {
    
    static func client(
        name: String,
        bundleID: String,
        targets: Set<ClientTarget> = [.staticFramework, .tests],
        dependencies: [TargetDependency] = [],
        testsDependencies: [TargetDependency] = [],
        infoPlist: InfoPlist = .default,
        additionalSettings: SettingsDictionary? = nil
    ) -> Project {
        var projectTargets: [Target] = []
        
        if targets.contains(.staticFramework) {
            projectTargets.append(
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .staticFramework,
                    bundleId: bundleID,
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            )
        }
        
        if targets.contains(.tests) {
            projectTargets.append(
                .target(
                    name: "\(name)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "\(bundleID).Tests",
                    sources: ["Tests/Sources/**"],
                    dependencies: testsDependencies + [.target(name: name)]
                )
            )
        }
        
        return Project(
            name: name,
            targets: projectTargets
        )
    }
}
