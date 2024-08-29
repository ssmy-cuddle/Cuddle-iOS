//
//  CommunityNavigation.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct CommunityNavigation {
    
    public static var initialState: Path.State {
        Path.State.main(Community.State())
    }
    
    public init() {}
    
    public enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case popToRoot
    }
    
    @ObservableState
    public struct State: Equatable {
        public var path = StackState<Path.State>()
        
        public init() {
            path.append(CommunityNavigation.initialState)
        }
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .path(action):
                switch action {
                case .element(_, .navigateToMainView(.register)):
                    state.path.append(.register(Register.State()))
                    return .none
                case .element(_, .navigateToRegister(.back)):
                    state.path.removeLast()
                    return .none
                case .element(_, .navigateToRegister(.didEndRegister)):
                    state.path.removeAll()
                    state.path.append(.main(Community.State()))
                    return .none
                default:
                    return .none
                }
            default:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}

// MARK: - Path
extension CommunityNavigation {
    
    @Reducer
    public struct Path {
        @ObservableState
        public enum State: Equatable {
            case main(Community.State)
            case register(Register.State)
        }
    
        public enum Action {
            case navigateToMainView(Community.Action)
            case navigateToRegister(Register.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: \.main, action: \.navigateToMainView) {
                Community()
            }
            Scope(state: \.register, action: \.navigateToRegister) {
                Register()
            }
        }
    }
}
