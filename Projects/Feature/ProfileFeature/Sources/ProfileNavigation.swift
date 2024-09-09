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
        .main(Profile.State(isRefreshRequired: true))
    }
    
    public enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case popToRoot
    }
    
    @ObservableState
    public struct State {
        public var path = StackState<Path.State>([ProfileNavigation.initialState])
        
        public init() {
//            path.append(ProfileNavigation.initialState)
        }
    }
    
    public init() {}

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .path(action):
                switch action {
                case .element(_, .main(.view(.registerButtonTapped))):
                    state.path.append(.input(CuddlerInput.State(inputType: .register)))
                    return .none
                case let .element(_, .main(.view(.editButtonTapped(cuddler)))):
                    state.path.append(.input(CuddlerInput.State(inputType: .edit(cuddler))))
                    return .none
                case let .element(_, action: .main(.view(.userProfileButtonTapped(userProfile)))):
                    state.path.append(.userProfile(UserProfileInputFeature.State(userProfile: userProfile)))
                    return .none
                case .element(_, .main):
                    return .none
                case .element(_, .input(.back)):
                    state.path.removeLast()
                    return .none
                case .element(_, .input(.didEndRegister)):
                    state.path.removeAll()
                    state.path.append(
                        .main(Profile.State(isRefreshRequired: true))
                    )
                    return .none
                    
                case .element(_, .userProfile(.view(.back))):
                    state.path.removeLast()
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
            case userProfile(UserProfileInputFeature.State)
        }
    
        public enum Action {
            case main(Profile.Action)
            case input(CuddlerInput.Action)
            case userProfile(UserProfileInputFeature.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: \.main, action: /Action.main) {
                Profile()
            }
            Scope(state: \.input, action: \.input) {
                CuddlerInput()
            }
            Scope(state: \.userProfile, action: \.userProfile) {
                UserProfileInputFeature()
            }
        }
    }
}
