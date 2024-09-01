//
//  Dependency+Domain.swift
//  DependencyPlugin
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import ProjectDescription

public enum Domain: CaseIterable {
    case base
    case community
    case original
    case profile
}

extension Domain: TargetDependencyCovertible {
    public var targetDependency: TargetDependency {
        switch self {
        case .base:
                .project(
                    target: "BaseDomain",
                    path: .relativeToRoot("Projects/Domain/BaseDomain")
                )
        case .community:
                .project(
                    target: "CommunityDomain",
                    path: .relativeToRoot("Projects/Domain/CommunityDomain")
                )
        case .original:
                .project(
                    target: "OriginalDomain",
                    path: .relativeToRoot("Projects/Domain/OriginalDomain")
                )
        case .profile:
                .project(
                    target: "ProfileDomain",
                    path: .relativeToRoot("Projects/Domain/ProfileDomain")
                )
        }
    }
}
