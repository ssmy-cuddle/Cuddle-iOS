//
//  Authentication.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 7/9/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct Authentication {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    public enum Action: Equatable {}
    
    // TODO: Implements Authentication
    
    public var body: some Reducer<State, Action> {
        Reduce { _, _ in .none }
    }
}
