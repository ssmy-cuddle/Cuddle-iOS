//
//  Content.swift
//  Cuddle
//
//  Created by mvldev7 on 7/6/24.
//

import Foundation

import ComposableArchitecture

public enum ContentType: Equatable {
    case splash
    case login
    case main
}

@Reducer
public struct Content {
    
    private enum Policy {
        static let splashScreenDurationNanoSeconds: UInt64 = 2 * 1_000_000_000
    }
    
    @ObservableState
    public struct State: Equatable {
        var contentType: ContentType = .splash
    }
    
    public enum Action: FeatureAction {
        case view(ViewAction)
        case inner(InnerAction)
    }
    
    public enum ViewAction: Equatable {
        case splashStarted
    }
    
    public enum InnerAction {
        case contentType(ContentType)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                switch action {
                case .splashStarted:
                    return .run {
                        try await Task.sleep(nanoseconds: Policy.splashScreenDurationNanoSeconds)
                        return await $0(Action.inner(.contentType(.main)))
                    }
                }
            case let .inner(action):
                switch action {
                case let .contentType(contentType):
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
