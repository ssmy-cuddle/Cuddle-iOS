//
//  Community.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

@Reducer
public struct Community {
    
    public init() {}
    
    public enum Action: Equatable {
        case register
    }
    
    @ObservableState
    public struct State: Equatable {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .register: .none
            }
        }
    }
}
