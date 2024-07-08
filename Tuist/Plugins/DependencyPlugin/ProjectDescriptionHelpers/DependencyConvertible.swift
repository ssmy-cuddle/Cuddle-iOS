//
//  DependencyConvertible.swift
//  DependencyPlugin
//
//  Created by mvldev7 on 7/8/24.
//

import Foundation

import ProjectDescription

protocol TargetDependencyCovertible {
    var targetDependency: TargetDependency { get }
}
