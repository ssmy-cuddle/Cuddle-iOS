//
//  AuthenticationCoordinator.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 7/15/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct AuthenticationCoordinator {
    
    public init() {}
    
    @Reducer
    public struct Path {
        @ObservableState
        public enum State: Equatable {
            case authenticationScreen(Authentication.State = .init())
        }
        
        public enum Action {
            case authentication(Authentication.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: \.authenticationScreen, action: \.authentication) {
                Authentication()
            }
        }
    }
    
    public enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case popToRoot
    }

    @ObservableState
    public struct State: Equatable {
        public var path = StackState<Path.State>()
        
        public init() {}
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .path(pathState):
                switch pathState {
                case let .element(id, action):
                    state.path.append(.authenticationScreen(.init()))
                    return .none
                default:
                    return .none
                }
            case .popToRoot:
                return .none
            }
        }
    }
}
