//
//  Feature+Target.swift
//  AppResourceManifests
//
//  Created by mvldev7 on 7/6/24.
//

import Foundation

import ProjectDescription

public enum FeatureTarget: CaseIterable {
    case staticFramework
    case interface
    case testing
    case example
    case tests
}
