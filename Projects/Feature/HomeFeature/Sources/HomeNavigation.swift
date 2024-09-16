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
    
    public init() {}
    
    @ObservableState
    public struct State {
        public var path = StackState<Path.State>([HomeNavigation.rootPath])
        
        public init() {}
    }
    
    public enum Action {
        case path(StackActionOf<Path>)
        case popToRoot
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            .none
        }
        .forEach(\.path, action: \.path)
    }
}

extension HomeNavigation {
    
    private static var rootPath: Path.State {
        .home(HomeFeature.State(isRefreshRequired: true))
    }
    
    @Reducer
    public enum Path {
        case home(HomeFeature)
    }
}
