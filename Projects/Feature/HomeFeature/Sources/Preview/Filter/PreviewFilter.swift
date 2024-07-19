//
//  PreviewFilter.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct PreviewFilter {
    
    public enum Action: Equatable {
        case selectPreviewType(PreviewType)
    }
    
    @ObservableState
    public struct State: Equatable {
        public let previewFilters: [PreviewType] = PreviewType.allCases
        public var selectedPreviewType: PreviewType = .default
        
        public init() {}
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .selectPreviewType(previewType):
                state.selectedPreviewType = previewType
                return .none
            }
        }
    }
}
