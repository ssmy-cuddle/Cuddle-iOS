//
//  FeatureAction.swift
//  BaseFeature
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

public protocol FeatureAction {
    associatedtype ViewAction
    associatedtype InnerAction
    associatedtype DelegateAction

    static func view(_: ViewAction) -> Self
    static func inner(_: InnerAction) -> Self
    static func delegate(_: DelegateAction) -> Self
}
