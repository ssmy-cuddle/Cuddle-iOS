//
//  Community.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/1/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

@Reducer
public struct Community {
    
    @ObservableState
    public struct State: Equatable {
        var categories: [CommunityCategory] = CommunityCategory.allCases
        var selectedCategory: CommunityCategory = .daily
    }
    
    public enum Action: Equatable {
        case changeCategory(CommunityCategory)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .changeCategory(category):
                state.selectedCategory = category
                return .none
            }
        }
    }
}
