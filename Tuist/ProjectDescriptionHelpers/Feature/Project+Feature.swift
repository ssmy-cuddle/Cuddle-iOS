//
//  Project+Feature.swift
//  AppResourceManifests
//
//  Created by mvldev7 on 7/6/24.
//

import ProjectDescription

public extension Project {
    
    static func feature(
        name: String,
        bundleID: String,
        targets: Set<FeatureTarget> = [.interface, .staticFramework, .testing, .example, .tests],
        dependencies: [TargetDependency] = [],
        interfaceDependencies: [TargetDependency] = [],
        testingDependencies: [TargetDependency] = [],
        exampleDependencies: [TargetDependency] = [],
        testsDependencies: [TargetDependency] = [],
        infoPlist: InfoPlist = .default,
        additionalSettings: SettingsDictionary? = nil,
        hasResources: Bool? = nil
    ) -> Project {
        var projectTargets: [Target] = []
        let hasResources = hasResources ?? false
        
        if targets.contains(.interface) {
            projectTargets.append(
                .target(
                    name: "\(name)Interface",
                    destinations: .iOS,
                    product: .staticLibrary,
                    bundleId: "\(bundleID).Interface",
                    sources: ["Interface/Sources/**"],
                    resources: [],
                    dependencies: interfaceDependencies
                )
            )
        }
        
        if targets.contains(.staticFramework) {
            let dependencies = dependencies + [
                targets.contains(.interface) ? .target(name: "\(name)Interface") : nil
            ].compactMap { $0 }
            projectTargets.append(
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .staticLibrary,
                    bundleId: bundleID,
                    sources: ["Sources/**"],
                    resources: hasResources
                    ? [.glob(pattern: "Resources/**", excluding: ["Resources/dummy.txt"])]
                    : [],
                    dependencies: dependencies + [
                    ]
                )
            )
        }
        
        if targets.contains(.testing) {
            projectTargets.append(
                .target(
                    name: "\(name)Testing",
                    destinations: .iOS,
                    product: .staticLibrary,
                    bundleId: "\(bundleID).Testing",
                    sources: ["Testing/Sources/**"],
                    resources: [.glob(pattern: "Testing/Resources/**", excluding: ["Testing/Resources/dummy.txt"])],
                    dependencies: testingDependencies + [
                        targets.contains(.interface) ? .target(name: "\(name)Interface") : nil
                    ].compactMap { $0 }
                )
            )
        }
        
        if targets.contains(.example) {
            projectTargets.append(
                .target(
                    name: "\(name)Example",
                    destinations: .iOS,
                    product: .app,
                    bundleId: "\(bundleID).Example",
                    infoPlist:.extendingDefault(
                        with: [
                            "UILaunchScreen": [
                                "UIColorName": "",
                                "UIImageName": "",
                            ],
                        ]
                    ),
                    sources: ["Example/Sources/**"],
                    resources: [],
                    dependencies: testingDependencies + [
                        .target(name: name),
                        targets.contains(.testing) ? .target(name: "\(name)Testing") : nil
                    ].compactMap { $0 }
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
                    infoPlist: .default,
                    sources: ["Tests/Sources/**"],
                    resources: [],
                    dependencies: testingDependencies + [
                        .target(name: name),
                        targets.contains(.testing) ? .target(name: "\(name)Testing") : nil
                    ].compactMap { $0 }
                )
            )
        }
        
        return Project(
            name: name,
            targets: projectTargets
        )
    }
}
