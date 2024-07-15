//
//  Dependency+Feature.swift
//  DependencyPlugin
//
//  Created by mvldev7 on 7/9/24.
//

import Foundation

import ProjectDescription

public enum Feature: CaseIterable {
    case authentification
}

extension Feature: TargetDependencyCovertible {
    public var targetDependency: TargetDependency {
        switch self {
        case .authentification:
                .project(
                    target: "AuthenticationFeature",
                    path: .relativeToRoot("Projects/Feature/AuthenticationFeature")
                )
        }
    }
}
