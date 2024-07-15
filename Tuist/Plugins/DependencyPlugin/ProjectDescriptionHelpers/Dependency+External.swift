//
//  Dependency+External.swift
//  Plugin
//
//  Created by mvldev7 on 7/7/24.
//

import Foundation

import ProjectDescription

public enum External {
    case composableArchitecture
    case swinject
    case swinjectAutoregistration
    case tcaCoordinators
}

extension External: CaseIterable {}

extension External: TargetDependencyCovertible {
    public var targetDependency: TargetDependency {
        switch self {
        case .composableArchitecture: .external(name: "ComposableArchitecture")
        case .swinject: .external(name: "Swinject")
        case .swinjectAutoregistration: .external(name: "SwinjectAutoregistration")
        case .tcaCoordinators: .external(name: "TCACoordinators")
        }
    }
}
