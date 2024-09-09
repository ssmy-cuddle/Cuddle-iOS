//
//  HomeNavigation.swift
//  HomeFeature
//
//  Created by mvldev7 on 9/9/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct HomeNavigation {
    
    public static var initialPath: Path.State {
        .home(HomeFeature.State())
    }
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var path = StackState<Path.State>([HomeNavigation.initialPath])
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        case popToRoot
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            .none
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}

extension HomeNavigation {
    
    @Reducer
    public struct Path {
        
        @ObservableState
        public enum State: Equatable {
            case home(HomeFeature.State)
        }
        
        public enum Action: Equatable {
            case home(HomeFeature.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: \.home, action: \.home) {
                HomeFeature()
            }
        }
    }
}
