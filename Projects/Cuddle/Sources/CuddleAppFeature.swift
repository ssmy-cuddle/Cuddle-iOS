//
//  CuddleAppFeature.swift
//  Cuddle
//
//  Created by mvldev7 on 9/19/24.
//

import Combine
import Foundation
import Security

import AuthenticationClient
import AuthenticationClientLive

import AuthenticationFeature

import ComposableArchitecture

public enum AppVisibility {
    case authentication
    case content(token: String)
}

@Reducer
public struct CuddleAppFeature {
    
    @ObservableState
    public struct State {
        public var visibility: AppVisibility = .authentication
        public var authentication: AuthenticationFeature.State = .init()
        public var content: Content.State = .init()
        
        public init() {
            @Dependency(\.authenticationClient) var authenticationClient
            let visibility: AppVisibility = if let token = try? authenticationClient.authentication()?.accessToken {
                .content(token: token)
            } else {
                .authentication
            }
            self.visibility = visibility
        }
    }
    
    public enum Action {
        case authentication(AuthenticationFeature.Action)
        case content(Content.Action)
        case logout
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.authentication, action: \.authentication) { AuthenticationFeature() }
        Scope(state: \.content, action: \.content) { Content() }
        Reduce { state, action in
            switch action {
            case let .authentication(.inner(.authentication(authentication))):
                state.visibility = .content(token: authentication.accessToken)
                return .none
            case .content(.profile(.path(.element(_, .main(.view(.logoutButtonTapped)))))):
                print("action: \(action)")
                state.visibility = .authentication
                state.content = .init()
                return .none
            case .logout:
                state.visibility = .authentication
                state.content = .init()
                return .none
            default:
                return .none
            }
        }
    }
}
//
//extension CuddleAppFeature {
//    
//    static let tokenKey = "userToken"
//    
//    static func loadToken(forKey key: String) -> String? {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: key,
//            kSecReturnData as String: true,
//            kSecMatchLimit as String: kSecMatchLimitOne
//        ]
//
//        var result: AnyObject?
//        let status = SecItemCopyMatching(query as CFDictionary, &result)
//
//        if status == errSecSuccess, let data = result as? Data {
//            return String(data: data, encoding: .utf8)
//        }
//
//        return nil
//    }
//    
//    // MARK: For Debug
//    
//    static func deleteToken(forKey key: String) -> Bool {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: key
//        ]
//
//        let status = SecItemDelete(query as CFDictionary)
//
//        return status == errSecSuccess
//    }
//}
