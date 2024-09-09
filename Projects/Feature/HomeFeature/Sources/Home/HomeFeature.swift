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
        }
        public enum InnerAction: Equatable {}
        public enum DelegateAction: Equatable {}
    }
    
    @ObservableState
    public struct State: Equatable {
        public var isSkeletonLoading: Bool {
            original.isSkeletonLoading || daily.isSkeletonLoading || profile.isSkeletonLoading
        }
        public var original = OriginalFeature.State()
        public var daily = DailyPreviewFeature.State()
        public var profile = ProfilePreviewFeature.State()
        
        public init() {}
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
            case let .view(action): self.reduce(viewAction: action, state: &state)
            default: .none
            }
        }
    }
}

extension HomeFeature {
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case .onAppear: self.onAppear()
        }
    }
    
    // MARK: View
    
    private func onAppear() -> Effect<Action> {
        .merge(
            .send(.original(.view(.onAppear))),
            .send(.daily(.view(.onAppear))),
            .send(.profile(.view(.onAppear)))
        )
    }
    
    // MARK: Inner
    
    // MARK: Delegate
}
