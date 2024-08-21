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
public struct CommunityCategory {
    
    @ObservableState
    public struct State: Equatable {
        var categories: [CommunityCategoryType] = CommunityCategoryType.allCases
        var selectedCategory: CommunityCategoryType = .daily
    }
    
    public enum Action: Equatable {
        case changeCategory(CommunityCategoryType)
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
