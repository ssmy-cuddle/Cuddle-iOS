//
//  AuthenticationClient.swift
//  AuthenticationClient
//
//  Created by mvldev7 on 9/19/24.
//

import Foundation

import Dependencies
import DependenciesMacros

@DependencyClient
public struct AuthenticationClient {
    public var authentication: () throws -> Authentication?
    public var requestAuthentication: (_ provider: String, _ code: String) async throws -> Authentication
    public var removeAuthentication: () async throws -> Void
}
