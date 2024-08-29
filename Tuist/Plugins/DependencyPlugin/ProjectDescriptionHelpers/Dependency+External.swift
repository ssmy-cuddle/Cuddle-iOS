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
    case kingfisher
    case lottie
}

extension External: CaseIterable {}

extension External: TargetDependencyCovertible {
    public var targetDependency: TargetDependency {
        switch self {
        case .composableArchitecture: .external(name: "ComposableArchitecture")
        case .kingfisher: .external(name: "Kingfisher")
        case .lottie: .external(name: "Lottie")
        }
    }
}
