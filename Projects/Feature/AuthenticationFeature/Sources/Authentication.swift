//
//  Authentication.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 7/9/24.
//

import Foundation

import AuthenticationClient

import BaseFeature

import ComposableArchitecture

@Reducer
public struct AuthenticationFeature {
    
    @Dependency(\.authenticationClient) private var authenticationClient
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var authentication: Authentication?
        
        public init() {}
    }
    public enum Action: Equatable, FeatureAction {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        public enum ViewAction: Equatable {
            case appleLoginRequested(identifier: String)
        }
        public enum InnerAction: Equatable {
            case authentication(Authentication)
        }
        public enum DelegateAction: Equatable {}
    }
    
    // TODO: Implements Authentication
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                self.reduce(viewAction: action, state: &state)
            default:
                .none
            }
            
        }
    }
}

extension AuthenticationFeature {
    
    // MARK: View
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case let .appleLoginRequested(identifier):
            self.appleLoginRequested(identifier: identifier)
        }
    }
    
    private func appleLoginRequested(identifier: String) -> Effect<Action> {
        .run {
            let authentication = try await authenticationClient.authentication(
                provider: "apple",
                code: identifier
            )
            let _ = saveToken(authentication.token, forKey: "userToken")
            return await $0(.inner(.authentication(authentication)))
        }
    }
    
//    private func appleLoginRequested(identifier: String) -> Effect<Action> {
//        .run {
//            try await Task.sleep(for: .seconds(2))
//            return await $0(.inner(.authentication(Authentication(token: "????????"))))
//        }
//    }
    
    private func authentication(_ authentication: Authentication, state: inout State) -> Effect<Action> {
        state.authentication = authentication
        return .none
    }
    
    private func saveToken(_ token: String, forKey key: String) -> Bool {
        guard let data = token.data(using: .utf8) else { return false }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary) // 기존 데이터 삭제 (중복 방지)
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
}
