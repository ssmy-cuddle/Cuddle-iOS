//
//  DailyPreviewFeature.swift
//  HomeFeature
//
//  Created by mvldev7 on 9/5/24.
//

import Foundation

import BaseFeature

import ComposableArchitecture

@Reducer
public struct DailyPreviewFeature {
    
    public enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        public enum ViewAction: Equatable {
            case onAppear
        }
        public enum InnerAction: Equatable {
            case dailys([DailyPreviewModel])
            case isSkeletonLoading(Bool)
        }
        public enum DelegateAction: Equatable {}
    }
    
    @ObservableState
    public struct State: Equatable {
        public var dailys: [DailyPreviewModel] = []
        public var isSkeletonLoading = false
        
        public init() {}
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

extension DailyPreviewFeature {
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case .onAppear: self.onAppear()
        }
    }
    
    private func reduce(innerAction: Action.InnerAction, state: inout State) -> Effect<Action> {
        switch innerAction {
        case let .dailys(dailys): self.dailys(dailys, state: &state)
        case let .isSkeletonLoading(isLoading): self.isSkeletonLoading(isLoading, state: &state)
        }
    }
    
    private func reduce(delegateAction: Action.DelegateAction, state: inout State) -> Effect<Action> {
        .none
    }
    
    // MARK: View
    
    private func onAppear() -> Effect<Action> {
        .run {
            try await Task.sleep(for: .milliseconds(1000))
            return await $0(.inner(.dailys(MockDailyContentGridItemModel.itemModels)))
        }
    }
    
    // MARK: Inner
    
    private func dailys(_ dailys: [DailyPreviewModel], state: inout State) -> Effect<Action> {
        state.dailys = dailys
        state.isSkeletonLoading = false
        return .none
    }
    
    private func isSkeletonLoading(_ isLoading: Bool, state: inout State) -> Effect<Action> {
        state.isSkeletonLoading = isLoading
        return .none
    }
}
