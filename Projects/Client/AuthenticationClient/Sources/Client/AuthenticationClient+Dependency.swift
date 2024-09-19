//
//  AuthenticationClient+Dependency.swift
//  AuthenticationClient
//
//  Created by mvldev7 on 9/19/24.
//

import Foundation

import Dependencies

public extension DependencyValues {
    var authenticationClient: AuthenticationClient {
        get { self[AuthenticationClient.self] }
        set { self[AuthenticationClient.self] = newValue }
    }
}
