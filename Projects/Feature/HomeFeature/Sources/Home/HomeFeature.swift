//
//  Home.swift
//  HomeFeature
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation
import SwiftUI

import BaseFeature

import ComposableArchitecture

@Reducer
public struct HomeFeature {
    
    public enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        case original(OriginalFeature.Action)
        case daily(DailyPreviewFeature.Action)
        case profile(ProfilePreviewFeature.Action)
        
        public enum ViewAction: Equatable {
            case onAppear
            case refresh
        }
        public enum InnerAction: Equatable {
            case isRefreshRequired(Bool)
        }
        public enum DelegateAction: Equatable {}
    }
    
    @ObservableState
    public struct State: Equatable {
        public var original = OriginalFeature.State()
        public var daily = DailyPreviewFeature.State()
        public var profile = ProfilePreviewFeature.State()
        public var isRefreshRequired: Bool
        
        public var isSkeletonLoading: Bool {
            original.isSkeletonLoading || daily.isSkeletonLoading || profile.isSkeletonLoading
        }
        
        public init(isRefreshRequired: Bool) {
            self.isRefreshRequired = isRefreshRequired
        }
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Scope(state: \.original, action: /Action.original) {
            OriginalFeature()
        }
        Scope(state: \.daily, action: /Action.daily) {
            DailyPreviewFeature()
        }
        Scope(state: \.profile, action: /Action.profile) {
            ProfilePreviewFeature()
        }
        Reduce { state, action in
            switch action {
            case let .view(action): 
                self.reduce(viewAction: action, state: &state)
            case let .inner(action): 
                self.reduce(innerAction: action, state: &state)
            case let .delegate(action):
                self.reduce(delegateAction: action, state: &state)
            default:
                .none
            }
        }
    }
}

extension HomeFeature {
    
    // MARK: View
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case .onAppear: 
            self.onAppear(state: &state)
        case .refresh: 
            self.refresh()
        }
    }
    
    private func onAppear(state: inout State) -> Effect<Action> {
        guard state.isRefreshRequired else { return .none }
        return .merge(
            .send(.original(.view(.onAppear))),
            .send(.daily(.view(.onAppear))),
            .send(.profile(.view(.onAppear))),
            .send(.inner(.isRefreshRequired(false)))
        )
    }
    
    private func refresh() -> Effect<Action> {
        .concatenate(
            .run { _ in try await Task.sleep(for: .seconds(1)) },
            .run { await $0(.original(.delegate(.refresh))) }
        )
    }
    
    // MARK: Inner
    
    private func reduce(innerAction: Action.InnerAction, state: inout State) -> Effect<Action> {
        switch innerAction {
        case let .isRefreshRequired(isRequired):
            self.isRefreshRequired(isRequired, state: &state)
        }
    }
    
    private func isRefreshRequired(_ isRequired: Bool, state: inout State) -> Effect<Action> {
        state.isRefreshRequired = isRequired
        return .none
    }
    
    // MARK: Delegate
    
    private func reduce(delegateAction: Action.DelegateAction, state: inout State) -> Effect<Action> {
        .none
    }
}
