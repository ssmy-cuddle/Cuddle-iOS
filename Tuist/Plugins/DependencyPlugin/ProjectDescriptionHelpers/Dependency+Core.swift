//
//  Dependency+Core.swift
//  DependencyPlugin
//
//  Created by mvldev7 on 7/8/24.
//

import Foundation

import ProjectDescription

public enum Core: CaseIterable {
    case appResource
    case designSystem
    case uiComponent
    case networking
}

extension Core: TargetDependencyCovertible {
    public var targetDependency: TargetDependency {
        switch self {
        case .appResource: .project(target: "AppResource", path: .relativeToRoot("Projects/Core/AppResource"))
        case .designSystem: .project(target: "DesignSystem", path: .relativeToRoot("Projects/Core/DesignSystem"))
        case .uiComponent: .project(target: "UIComponent", path: .relativeToRoot("Projects/Core/UIComponent"))
        case .networking: .project(target: "Networking", path: .relativeToRoot("Projects/Core/Networking"))
        }
    }
}
