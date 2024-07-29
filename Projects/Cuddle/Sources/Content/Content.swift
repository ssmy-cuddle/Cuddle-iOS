//
//  Content.swift
//  Cuddle
//
//  Created by mvldev7 on 7/6/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

@Reducer
public struct Content {
    
    @ObservableState
    public struct State: Equatable {
        var navigationTabs: [NavigationTabType] = NavigationTabType.allCases
        var contentType: NavigationTabType = .default
    }
    
    public enum Action: FeatureAction {
        case view(ViewAction)
        case inner(InnerAction)
    }
    
    public enum ViewAction: Equatable {
        case changeTab(NavigationTabType)
    }
    
    public enum InnerAction {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                switch action {
                case let .changeTab(contentType):
                    state.contentType = contentType
                    return .none
                }
            }
        }
    }
}

public protocol FeatureAction {
  associatedtype ViewAction
  associatedtype InnerAction

  // NOTE: view 에서 사용되는 Action 을 정의합니다.
  static func view(_: ViewAction) -> Self

  // NOTE: 그 외 Reducer 내부적으로 사용되는 Action 을 정의합니다.
  static func inner(_: InnerAction) -> Self
}
