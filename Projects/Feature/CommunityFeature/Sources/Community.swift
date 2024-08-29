//
//  Community.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation
import SwiftUI

import BaseFeature

import ComposableArchitecture

@Reducer
public struct Community {
    
    public init() {}
    
    public enum Action: Equatable {
        case register
        case daily(Daily.Action)
    }
    
    @ObservableState
    public struct State: Equatable {
        public var isLoading: Bool = false
        public var daily = Daily.State()
    }
    
    public var body: some Reducer<State, Action> {
        Scope(state: \.daily, action: /Action.daily) {
            Daily()
        }
        Reduce { state, action in
            switch action {
//            case .register:
//                return .none
            case let .daily(.inner(.loading(isLoading))):
                state.isLoading = isLoading
                return .none
            default:
                return .none
            }
        }
    }
}
