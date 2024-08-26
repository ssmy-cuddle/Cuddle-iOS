//
//  ProfileNavigation.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/25/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ProfileNavigation {
    
    public static var initialState: Path.State {
        .main(Profile.State())
    }
    
    public enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case popToRoot
    }
    
    @ObservableState
    public struct State {
        public var path = StackState<Path.State>()
        
        public init() {
            path.append(ProfileNavigation.initialState)
        }
    }
    
    public init() {}

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .path(action):
                switch action {
                case .element(_, .main(.register)):
                    state.path.append(.input(CuddlerInput.State(inputType: .register)))
                    return .none
                case let .element(_, .main(.edit(cuddler))):
                    state.path.append(.input(CuddlerInput.State(inputType: .edit(cuddler))))
                    return .none
                case .element(_, .main):
                    return .none
                case .element(_, .input(.back)):
                    state.path.removeLast()
                    return .none
                case .element(_, .input(.didEndRegister)):
                    state.path.removeAll()
                    state.path.append(
                        .main(Profile.State(isRegistered: true))
                    )
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

extension ProfileNavigation {
    @Reducer
    public struct Path {
        @ObservableState
        public enum State: Equatable {
            case main(Profile.State)
            case input(CuddlerInput.State)
        }
    
        public enum Action {
            case main(Profile.Action)
            case input(CuddlerInput.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: \.main, action: \.main) {
                Profile()
            }
            Scope(state: \.input, action: \.input) {
                CuddlerInput()
            }
        }
    }
}
