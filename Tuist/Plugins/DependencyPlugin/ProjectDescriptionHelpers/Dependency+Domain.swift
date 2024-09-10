//
//  Dependency+Client.swift
//  DependencyPlugin
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import ProjectDescription

public enum Client: CaseIterable {
    case base
    case community
    case original
    case profile
}

extension Client: TargetDependencyCovertible {
    public var targetDependency: TargetDependency {
        switch self {
        case .base:
                .project(
                    target: "BaseClient",
                    path: .relativeToRoot("Projects/Client/BaseClient")
                )
        case .community:
                .project(
                    target: "CommunityClient",
                    path: .relativeToRoot("Projects/Client/CommunityClient")
                )
        case .original:
                .project(
                    target: "OriginalClient",
                    path: .relativeToRoot("Projects/Client/OriginalClient")
                )
        case .profile:
                .project(
                    target: "ProfileClient",
                    path: .relativeToRoot("Projects/Client/ProfileClient")
                )
        }
    }
}
