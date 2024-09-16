//
//  CommunityFeature.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation
import SwiftUI

import BaseFeature

import ComposableArchitecture

@Reducer
public struct CommunityFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var daily = Daily.State()
        public var isRefreshRequired: Bool
        public var isLoading: Bool { daily.isLoading }
        
        public init(isRefreshRequired: Bool) {
            self.isRefreshRequired = isRefreshRequired
        }
    }
    
    public enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        case daily(Daily.Action)
        
        public enum ViewAction: Equatable {
            case onAppear
            case refresh
            case registerButtonTapped
        }
        public enum InnerAction: Equatable {
            case isRefreshRequired(Bool)
        }
        public enum DelegateAction: Equatable {}
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Scope(state: \.daily, action: \.daily) {
            Daily()
        }
        Reduce { state, action in
            switch action {
            case let .view(action):
                self.reduce(viewAction: action, state: &state)
            case let .inner(action):
                self.reduce(innerAction: action, state: &state)
            default:
                .none
            }
        }
    }
}

extension CommunityFeature {
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case .onAppear:
            self.onAppear(state: &state)
        case .refresh:
            self.refresh(state: &state)
        case .registerButtonTapped:
            .none
        }
    }
    
    private func onAppear(state: inout State) -> Effect<Action> {
        guard state.isRefreshRequired else { return .none }
        return .concatenate(
            .run { await $0(.daily(.view(.onAppear))) },
            .run { await $0(.inner(.isRefreshRequired(false))) }
        )
    }
    
    private func refresh(state: inout State) -> Effect<Action> {
        .concatenate(
            .run { _ in try await Task.sleep(for: .seconds(1)) },
            .run {
                await $0(.daily(.delegate(.refresh)))
            }
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
}
