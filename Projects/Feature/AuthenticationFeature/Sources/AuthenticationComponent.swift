//
//  AuthenticationComponent.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 7/9/24.
//

import Foundation
import SwiftUI

import AuthenticationFeatureInterface

import ComposableArchitecture

public struct AuthenticationComponent: AuthenticationBuilder {
    
    public init() {}
    
    public func build() -> any View {
        let store: StoreOf<AuthenticationFeature> = Store(initialState: AuthenticationFeature.State()) {
            AuthenticationFeature()
        }
        return AuthenticationView(store: store)
    }
}
