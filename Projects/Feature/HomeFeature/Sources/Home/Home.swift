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
public struct Home {
    
    public enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        case original(Original.Action)
        
        public enum ViewAction: Equatable {
            
        }
        
        public enum InnerAction: Equatable {
            
        }
        
        public enum DelegateAction: Equatable {
        }
    }
    
    @ObservableState
    public struct State: Equatable {
        public var isLoading: Bool = false
        public var original: Original.State = .init()
        
        public init() {}
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Scope(state: \.original, action: \.original) { Original() }
        Reduce { state, action in
            switch action {
            case let .original(.delegate(.isLoading(isLoading))):
                self.isLoading(isLoading, state: &state)
            default:
                .none
            }
        }
    }
}

extension Home {
    private func isLoading(_ isLoading: Bool, state: inout State) -> Effect<Action> {
        state.isLoading = isLoading
        return .none
    }
}
