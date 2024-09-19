//
//  DiaryNavigation.swift
//  DiaryFeature
//
//  Created by mvldev7 on 9/20/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct DiaryNavigation {
    
    public init() {}
    
    @ObservableState
    public struct State {
        public var path = StackState<Path.State>([DiaryNavigation.rootPath])
        
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

extension DiaryNavigation {
    
    private static var rootPath: Path.State {
        .main(DiaryFeature.State())
    }
    
    @Reducer
    public enum Path {
        case main(DiaryFeature)
    }
}
