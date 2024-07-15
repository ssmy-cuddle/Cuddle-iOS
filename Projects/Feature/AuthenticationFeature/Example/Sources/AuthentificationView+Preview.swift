//
//  AuthentificationView+Preview.swift
//  AuthenticationFeatureExample
//
//  Created by mvldev7 on 7/8/24.
//

import Foundation
import SwiftUI

import AuthenticationFeature
import ComposableArchitecture

#Preview {
    AuthenticationView(store: StoreOf<Authentication>(initialState: Authentication.State()) {
        Authentication()
    })
}
