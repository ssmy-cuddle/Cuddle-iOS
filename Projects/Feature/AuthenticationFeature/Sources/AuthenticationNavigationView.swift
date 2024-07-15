//
//  AuthenticationNavigationView.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 7/15/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct AuthenticationNavigationView: View {
    
    @State var store: StoreOf<AuthenticationCoordinator>
    
    public init(store: StoreOf<AuthenticationCoordinator>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(
            path: $store.scope(
                state: \.path,
                action: \.path
            )
        ) {
            AuthenticationView(store: .init(initialState: Authentication.State()) {
                Authentication()
            })
            //            NavigationLink(state: AuthenticationCoordinator.Path.State.authenticationScreen(.init())) {
            //                AuthenticationView(store: .init(initialState: Authentication.State()) {
            //                    Authentication()
            //                })
            //            }
        } destination: { store in
            switch store.state {
            case .authenticationScreen:
                if let store = store.scope(state: \.authenticationScreen, action: \.authentication) {
                    AuthenticationView(store: store)
                }
            }
        }
    }
}
