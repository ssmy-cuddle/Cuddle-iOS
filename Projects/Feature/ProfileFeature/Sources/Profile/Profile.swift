//
//  Profile.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/19/24.
//

import Foundation

import BaseFeature
import ProfileClient
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
    
    public enum Action: Equatable, FeatureAction {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        public enum ViewAction: Equatable {
            case onAppear
            case registerButtonTapped
            case editButtonTapped(CuddlerProfileModel)
            case userProfileButtonTapped(UserProfileModel?)
            case logoutButtonTapped
        }
        
        public enum InnerAction: Equatable {
            case profile(UserProfileModel)
            case isLoading(Bool)
            case isRefreshRequired(Bool)
        }
        
        public enum DelegateAction: Equatable {}
    }
    
    @ObservableState
    public struct State: Equatable {
        public var isRefreshRequired: Bool
        public var profile: UserProfileModel?
        public var cuddlerItems: [CuddlerViewType] {
            (profile?.cuddlers ?? []).map { .profile($0) } + [.add]
        }
        public var isLoading: Bool = false
        
        public init(isRefreshRequired: Bool) {
            self.isRefreshRequired = isRefreshRequired
        }
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(action): self.reduce(viewAction: action, state: &state)
            case let .inner(action): self.reduce(innerAction: action, state: &state)
            case .delegate: .none
            }
        }
    }
}

// MARK: - Effect

extension Profile {
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case .onAppear: self.onAppear(state: &state)
        case .registerButtonTapped: .none
        case .editButtonTapped: .none
        case .userProfileButtonTapped: .none
        case .logoutButtonTapped: .none
        }
    }
    
    private func reduce(innerAction: Action.InnerAction, state: inout State) -> Effect<Action> {
        switch innerAction {
        case let .profile(profile): self.profile(profile, state: &state)
        case let .isLoading(isLoading): self.isLoading(isLoading, state: &state)
        case let .isRefreshRequired(isRequired): self.isRefreshRequired(isRequired, state: &state)
        }
    }
    
    // MARK: View
    
    private func onAppear(state: inout State) -> Effect<Action> {
        guard state.isRefreshRequired else { return .none }
        return .run {
            await $0(.inner(.isRefreshRequired(false)))
            await $0(.inner(.isLoading(true)))
            let profile = try await getUserProfileUseCase.execute().asModel
            await $0(.inner(.profile(profile)))
            await $0(.inner(.isLoading(false)))
        }
    }
    
    // MARK: Inner
    
    private func profile(_ profile: UserProfileModel, state: inout State) -> Effect<Action> {
        state.profile = profile
        return .none
    }
    
    private func isLoading(_ isLoading: Bool, state: inout State) -> Effect<Action> {
        state.isLoading = isLoading
        return .none
    }
    
    private func isRefreshRequired(_ isRequired: Bool, state: inout State) -> Effect<Action> {
        state.isRefreshRequired = isRequired
        return .none
    }
}
