//
//  ProfileNavigation.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/25/24.
//

import Foundation

import ProfileFeatureInterface

import ComposableArchitecture


@Reducer
public struct ProfileNavigation {
    
    public enum Action {
        case path(StackActionOf<Path>)
        case popToRoot
    }
    
    @ObservableState
    public struct State {
        public var path = StackState<Path.State>([.main(.init(isRefreshRequired: true))])
        
        public init() {}
    }
    
    public init() {}

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .path(.element(id: _, action: .main(action))):
                reduce(mainAction: action, state: &state)
            case let .path(.element(id: _, action: .cuddlerProfile(action))):
                reduce(cuddlerProfileAction: action, state: &state)
            case let .path(.element(id: _, action: .userProfile(action))):
                reduce(userProfileAction: action, state: &state)
            case .popToRoot:
                popToRoot(state: &state)
            default:
                .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension ProfileNavigation {
    
    @Reducer
    public enum Path {
        case main(Profile)
        case userProfile(UserProfileInputFeature)
        case cuddlerProfile(CuddlerInput)
    }
    
    
//    @Reducer
//    public struct Path {
//        @ObservableState
//        public enum State: Equatable {
//            case main(Profile.State)
//            case input(CuddlerInput.State)
//            case userProfile(UserProfileInputFeature.State)
//        }
//    
//        public enum Action {
//            case main(Profile.Action)
//            case input(CuddlerInput.Action)
//            case userProfile(UserProfileInputFeature.Action)
//        }
//        
//        public var body: some ReducerOf<Self> {
//            Scope(state: \.main, action: \.main) {
//                Profile()
//            }
//            Scope(state: \.input, action: \.input) {
//                CuddlerInput()
//            }
//            Scope(state: \.userProfile, action: \.userProfile) {
//                UserProfileInputFeature()
//            }
//        }
//    }
}

extension ProfileNavigation {
    
    // MARK: - Main
    
    private func reduce(mainAction: Profile.Action, state: inout State) -> Effect<Action> {
        switch mainAction {
        case .view(.registerButtonTapped): 
            self.registerButtonTapped(state: &state)
        case let .view(.editButtonTapped(profile)): 
            self.editButtonTapped(profile: profile, state: &state)
        case let .view(.userProfileButtonTapped(profile)):
            self.editUserProfileButtonTapped(profile: profile, state: &state)
        default:
            .none
        }
    }
    
    private func registerButtonTapped(state: inout State) -> Effect<Action> {
        state.path.append(.cuddlerProfile(CuddlerInput.State(inputType: .register)))
        return .none
    }
    
    private func editButtonTapped(profile: CuddlerProfileModel, state: inout State) -> Effect<Action> {
        state.path.append(.cuddlerProfile(CuddlerInput.State(inputType: .edit(profile))))
        return .none
    }
    
    private func editUserProfileButtonTapped(profile: UserProfileModel?, state: inout State) -> Effect<Action> {
        state.path.append(.userProfile(UserProfileInputFeature.State(userProfile: profile)))
        return .none
    }
    
    // MARK: - Cuddler Profile
    
    private func reduce(cuddlerProfileAction: CuddlerInput.Action, state: inout State) -> Effect<Action> {
        switch cuddlerProfileAction {
        case .back:
            self.backButtonTapped(state: &state)
        case .didEndRegister:
            self.cuddlerRegistered(state: &state)
        default:
            .none
        }
    }

    private func backButtonTapped(state: inout State) -> Effect<Action> {
        state.path.removeLast()
        return .none
    }
    
    private func cuddlerRegistered(state: inout State) -> Effect<Action> {
        state.path.removeAll()
        state.path.append(.main(.init(isRefreshRequired: true)))
        return .none
    }
    
    // MARK: - User Profile
    
    private func reduce(userProfileAction: UserProfileInputFeature.Action, state: inout State) -> Effect<Action> {
        switch userProfileAction {
        case .view(.back):
            self.backButtonTapped(state: &state)
        default:
            .none
        }
    }
    
    // MARK: - PopToRoot
    
    private func popToRoot(state: inout State) -> Effect<Action> {
        state.path.removeAll()
        return .none
    }
}
