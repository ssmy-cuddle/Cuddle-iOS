//
//  Original.swift
//  HomeFeature
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation
import SwiftUI

import BaseFeature
import OriginalClient

import ComposableArchitecture

@Reducer
public struct OriginalFeature {
    
    @Dependency(\.originalClient) private var originalClient
    
    public enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        public enum ViewAction: Equatable {
            case onAppear
        }
        public enum InnerAction: Equatable {
            case originals([OriginalContentModel])
            case isSkeletonLoading(Bool)
        }
        public enum DelegateAction: Equatable {
            case refresh
        }
    }
    
    public struct State: Equatable {
        public var originals: [OriginalContentModel] = []
        public var isSkeletonLoading: Bool = false
        
        public init() {}
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(action): self.reduceViewAction(action, state: &state)
            case let .inner(action): self.reduceInnerAction(action, state: &state)
            case let .delegate(action): self.reduceDelegateAction(action, state: &state)
            }
        }
    }
}

extension OriginalFeature {
    
    private func reduceViewAction(
        _ action: Action.ViewAction,
        state: inout State
    ) -> Effect<Action> {
        switch action {
        case .onAppear: self.onAppear()
        }
    }
    
    private func reduceInnerAction(
        _ action: Action.InnerAction,
        state: inout State
    ) -> Effect<Action> {
        switch action {
        case let .originals(originals): self.originals(originals, state: &state)
        case let .isSkeletonLoading(isLoading): self.isSkeletonLoading(isLoading, state: &state)
        }
    }
    
    private func reduceDelegateAction(
        _ action: Action.DelegateAction,
        state: inout State
    ) -> Effect<Action> {
        switch action {
        case .refresh: self.refresh(state: &state)
        }
    }
}

extension OriginalFeature {
    
    // MARK: View
    
    private func onAppear() -> Effect<Action> {
        .run {
            await $0(.inner(.isSkeletonLoading(true)))
            let originals = try await originalClient.list(id: "")
                .map(\.asModel)
            return await $0(.inner(.originals(originals)))
        }
    }
    
    // MARK: Inner
    
    private func originals(
        _ originals: [OriginalContentModel],
        state: inout State
    ) -> Effect<Action> {
        state.originals = originals
        return .run {
            await $0(.inner(.isSkeletonLoading(false)))
        }
    }
    
    // MARK: Delegate
    
    private func refresh(state: inout State) -> Effect<Action> {
        .run {
            let originals = try await originalClient.list(id: "")
                .map(\.asModel)
            return await $0(.inner(.originals(originals)))
        }
    }
    
    private func isSkeletonLoading(_ isLoading: Bool, state: inout State) -> Effect<Action> {
        state.isSkeletonLoading = isLoading
        return .none
    }
}
