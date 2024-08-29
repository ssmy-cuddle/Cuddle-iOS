//
//  Profile.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/19/24.
//

import Foundation

import BaseFeature
import ProfileDomain
import ProfileFeatureInterface

import ComposableArchitecture

public enum CuddlerViewType {
    case profile(CuddlerProfileModel)
    case add
    
    public var value: String {
        switch self {
        case let .profile(profile): profile.name
        case .add: "add"
        }
    }
}

extension CuddlerViewType: Equatable {}

@Reducer
public struct Profile {
    
    @Dependency(\.getUserProfileUseCase) var getUserProfileUseCase: GetUserProfileUseCase
    
    public init() {}
    
    public enum Action: Equatable, ReducerAction {
        case view(ViewAction)
        case inner(InnerAction)
        
        public enum ViewAction: Equatable {
            case onAppear
            case registerButtonTapped
            case editButtonTapped(CuddlerProfileModel)
        }
        
        public enum InnerAction: Equatable {
            case profile(UserProfileModel)
        }
    }
    
    @ObservableState
    public struct State: Equatable {
        public var profile: UserProfileModel?
        public var cuddlerItems: [CuddlerViewType] {
            (profile?.cuddlers ?? []).map { .profile($0) } + [.add]
        }
        public var isLoading: Bool = false
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.onAppear): onAppear(state: &state)
            case let .inner(.profile(profile)): self.profile(profile, state: &state)
            default: .none
            }
        }
    }
}

// MARK: - Effect

extension Profile {
    
    private func onAppear(state: inout State) -> Effect<Action> {
        state.isLoading = true
        return .run { send in
            let profile = try await getUserProfileUseCase.execute()
            await send(.inner(.profile(profile.asModel)))
        }
    }
    
    private func profile(_ profile: UserProfileModel, state: inout State) -> Effect<Action> {
        state.profile = profile
        state.isLoading = false
        return .none
    }
}
