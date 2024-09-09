//
//  ProfilePreview.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/29/24.
//

import Foundation
import SwiftUI

import BaseFeature

import ComposableArchitecture

@Reducer
public struct ProfilePreviewFeature {
    
    public enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        public enum ViewAction: Equatable {
            case onAppear
        }
        public enum InnerAction: Equatable {
            case profiles([ProfilePreviewModel])
        }
        public enum DelegateAction: Equatable {}
    }
    
    @ObservableState
    public struct State: Equatable {
        public var profiles: [ProfilePreviewModel] = []
        public var isSkeletonLoading = false
    }
    
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(action): self.reduce(viewAction: action, state: &state)
            case let .inner(action): self.reduce(innerAction: action, state: &state)
            case let .delegate(action): self.reduce(delegateAction: action, state: &state)
            }
        }
    }
}

extension ProfilePreviewFeature {
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case .onAppear: self.onAppear()
        }
    }
    
    private func reduce(innerAction: Action.InnerAction, state: inout State) -> Effect<Action> {
        switch innerAction {
        case let .profiles(profiles): self.profiles(profiles, state: &state)
        }
    }
    
    private func reduce(delegateAction: Action.DelegateAction, state: inout State) -> Effect<Action> {
        .none
    }
    
    // MARK: View
    
    private func onAppear() -> Effect<Action> {
        .run {
            try await Task.sleep(for: .milliseconds(1000))
            return await $0(.inner(.profiles(MockProfilePreviewModel.items)))
        }
    }
    
    // MARK: Inner
    
    private func profiles(_ profiles: [ProfilePreviewModel], state: inout State) -> Effect<Action> {
        state.profiles = profiles
        state.isSkeletonLoading = false
        return .none
    }
    
    private func isSkeletonLoading(_ isLoading: Bool, state: inout State) -> Effect<Action> {
        state.isSkeletonLoading = isLoading
        return .none
    }
}
