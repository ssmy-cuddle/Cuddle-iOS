//
//  ReducerAction.swift
//  BaseFeature
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

public protocol ReducerAction {
    associatedtype ViewAction
    associatedtype InnerAction

    static func view(_: ViewAction) -> Self
    static func inner(_: InnerAction) -> Self
}
