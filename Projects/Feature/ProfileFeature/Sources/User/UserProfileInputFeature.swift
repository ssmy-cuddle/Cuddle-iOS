//
//  UserProfileInputFeature.swift
//  ProfileFeature
//
//  Created by mvldev7 on 9/7/24.
//

import Foundation

import BaseFeature
import ProfileFeatureInterface

import ComposableArchitecture

public enum UserProfileInputType {
    case register
    case edit(UserProfileModel)
}

@Reducer
public struct UserProfileInputFeature {
    
    public enum Action: FeatureAction, BindableAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        case binding(BindingAction<State>)
        
        public enum ViewAction: Equatable {
            case back
        }
        public enum InnerAction: Equatable {}
        public enum DelegateAction: Equatable {}
    }
    
    @ObservableState
    public struct State: Equatable {
        public var image: ImageStatus
        public var name: String
        public var description: String
        public var isConfirmButtonEnabled: Bool {
            image != .none && name != "" && description != ""
        }
        
        public init(userProfile: UserProfileModel?) {
            self.image = if let imageURL = userProfile?.imageURL {
                .url(imageURL)
            } else {
                .none
            }
            self.name = userProfile?.name ?? ""
            self.description = userProfile?.description ?? ""
        }
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .view(action): reduce(viewAction: action, state: &state)
            case let .inner(action): reduce(innerAction: action, state: &state)
            case let .delegate(action): reduce(delegateAction: action, state: &state)
            case .binding: .none
            }
        }
    }
}

extension UserProfileInputFeature {
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case .back: .none
        }
    }
    
    private func reduce(innerAction: Action.InnerAction, state: inout State) -> Effect<Action> {
        
    }
    
    private func reduce(delegateAction: Action.DelegateAction, state: inout State) -> Effect<Action> {
        
    }
}
