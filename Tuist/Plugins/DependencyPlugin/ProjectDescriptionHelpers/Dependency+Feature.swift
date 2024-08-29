//
//  Dependency+Feature.swift
//  DependencyPlugin
//
//  Created by mvldev7 on 7/9/24.
//

import Foundation

import ProjectDescription

public enum Feature: CaseIterable {
    case base
    case authentification
    case home
    case community
    case profile
}

extension Feature: TargetDependencyCovertible {
    public var targetDependency: TargetDependency {
        switch self {
        case .base:
                .project(
                    target: "BaseFeature",
                    path: .relativeToRoot("Projects/Feature/BaseFeature")
                )
        case .authentification:
                .project(
                    target: "AuthenticationFeature",
                    path: .relativeToRoot("Projects/Feature/AuthenticationFeature")
                )
        case .home:
                .project(
                    target: "HomeFeature",
                    path: .relativeToRoot("Projects/Feature/HomeFeature")
                )
        case .community:
                .project(
                    target: "CommunityFeature",
                    path: .relativeToRoot("Projects/Feature/CommunityFeature")
                )
        case .profile:
                .project(
                    target: "ProfileFeature",
                    path: .relativeToRoot("Projects/Feature/ProfileFeature")
                )
        }
    }
}
