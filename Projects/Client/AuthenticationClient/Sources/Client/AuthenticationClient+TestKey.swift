//
//  AuthenticationClient+TestKey.swift
//  AuthenticationClient
//
//  Created by mvldev7 on 9/19/24.
//

import Foundation

import Dependencies

extension AuthenticationClient: TestDependencyKey {
    
    public static var testValue: AuthenticationClient = AuthenticationClient(
        authentication: { _, _ in try await Self.authentication() }
    )
    
    private static func authentication() async throws -> Authentication {
        try await Task.sleep(for: .milliseconds(1000))
        return Authentication(
            token: "example token"
        )
    }
}
