//
//  Original.swift
//  HomeFeature
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation
import SwiftUI

import BaseFeature
import OriginalDomain

import ComposableArchitecture

@Reducer
public struct Original {
    
    @Dependency(\.getCuddleOriginalListUseCase) private var getCuddleOriginalListUseCase
    
    public enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        public enum ViewAction: Equatable {
            case onAppear
        }
        public enum InnerAction: Equatable {
            case contents([OriginalContentModel])
        }
        public enum DelegateAction: Equatable {
            case isLoading(Bool)
        }
    }
    
    public struct State: Equatable {
        public var contents: [OriginalContentModel] = []
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.onAppear):
                self.original(state: &state)
            case let .inner(.contents(contents)):
                self.contents(contents, state: &state)
            case let .delegate(.isLoading(isLoading)):
                .none
            }
        }
    }
}

public extension Original {
    func original(state: inout State) -> Effect<Action> {
        .run { send in
//            await send(.delegate(.isLoading(true)))
            let contents = try await getCuddleOriginalListUseCase.execute()
                .map(\.asModel)
            return await send(.inner(.contents(contents)))
        }
    }
    
    func contents(
        _ contents: [OriginalContentModel],
        state: inout State
    ) -> Effect<Action> {
        state.contents = contents
        return .run { await $0(.delegate(.isLoading(false))) }
    }
}
