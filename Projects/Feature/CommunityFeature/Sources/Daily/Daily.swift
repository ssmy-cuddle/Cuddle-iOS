//
//  Daily.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/5/24.
//

import Foundation
import SwiftUI

import BaseFeature
import CommunityClient

import ComposableArchitecture

@Reducer
public struct Daily {
    
    @Dependency(\.getDailyContentsUseCase) private var getDailyContentsUseCase
    @Dependency(\.likeDailyUseCase) private var likeDailyUseCase
    
    public enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        public enum ViewAction: Equatable {
            case onAppear
            case writeComment(UUID)
            case like(UUID, isLike: Bool)
        }
        
        public enum InnerAction: Equatable {
            case contents([DailyContentModel])
            case update(DailyContentModel, index: Int)
            case isLoading(Bool)
        }
        
        public enum DelegateAction: Equatable {
            case refresh
        }
    }
    
    @ObservableState
    public struct State: Equatable {
        var contents: [DailyContentModel] = []
        var isLoading: Bool = false
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                self.reduce(viewAction: action, state: &state)
            case let .inner(action):
                self.reduce(innerAction: action, state: &state)
            case let .delegate(action):
                self.reduce(delegateAction: action, state: &state)
            }
        }
    }
}

extension Daily {
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case .onAppear: 
            self.onAppear(state: &state)
        case let .like(id, isLike):
            self.like(id: id, isLike: isLike, state: &state)
        case .writeComment:
            .none
        }
    }
    
    private func reduce(innerAction: Action.InnerAction, state: inout State) -> Effect<Action> {
        switch innerAction {
        case let .contents(dailys):
            self.contents(dailys, state: &state)
        case let .isLoading(isLoading):
            self.isLoading(isLoading, state: &state)
        case let .update(daily, index):
            self.update(daily: daily, at: index, state: &state)
        }
    }
    
    private func reduce(delegateAction: Action.DelegateAction, state: inout State) -> Effect<Action> {
        switch delegateAction {
        case .refresh:
            self.refresh(state: &state)
        }
    }
    
    // MARK: View
    
    private func onAppear(state: inout State) -> Effect<Action> {
        .concatenate(
            .run { await $0(.inner(.isLoading(true))) },
            .run {
                let dailys = try await getDailyContentsUseCase.execute()
                    .map { $0.asModel }
                return await $0(.inner(.contents(dailys)))
            },
            .run { await $0(.inner(.isLoading(false))) }
        )
    }
    
    // MARK: Inner
    
    private func contents(
        _ contents: [DailyContentModel],
        state: inout State
    ) -> Effect<Action> {
        state.contents = contents
        return .none
    }
    
    private func isLoading(_ isLoading: Bool, state: inout State) -> Effect<Action> {
        state.isLoading = isLoading
        return .none
    }
    
    private func update(
        daily: DailyContentModel,
        at index: Int,
        state: inout State
    ) -> Effect<Action> {
        var localState = state
        localState.contents.remove(at: index)
        localState.contents.insert(daily, at: index)
        state.contents = localState.contents
        return .none
    }
    
    private func like(
        id: UUID,
        isLike: Bool,
        state: inout State
    ) -> Effect<Action> {
        let localState = state
        return .run {
            let daily = try await likeDailyUseCase.execute(
                parameters: .init(id: id, isLike: isLike)
            ).asModel
            if let index = localState.contents.firstIndex(where: { $0.id == id }) {
                return await $0(.inner(.update(daily, index: index)))
            }
            return await $0(.inner(.contents(localState.contents)))
        }
    }
    
    // MARK: Delegate
    
    private func refresh(state: inout State) -> Effect<Action> {
        .run { send in
            let contents = try await getDailyContentsUseCase.execute()
                .map { $0.asModel }
            return await send(.inner(.contents(contents)))
        }
    }
}
