//
//  DiaryFeature.swift
//  DiaryFeature
//
//  Created by mvldev7 on 9/20/24.
//

import Foundation

import BaseFeature

import ComposableArchitecture

@Reducer
public struct DiaryFeature {
    
    @ObservableState
    public struct State {
        
    }
    
    public enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        // View에 관련된 Event ex) case xxxxButtonTapped
        public enum ViewAction: Equatable {}
        
        // Reducer 내부에서 State 변경에 활용하는 Event ex) case dailys([DailyModel])
        public enum InnerAction: Equatable {}
        
        // 외부에서 활용하는 Event (아마 쓸 일 없을 듯)
        public enum DelegateAction: Equatable {}
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            .none
        }
    }
}

extension DiaryFeature {}
