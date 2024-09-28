//
//  AuthenticationClient+LiveKey.swift
//  AuthenticationClient
//
//  Created by mvldev7 on 9/28/24.
//

import Foundation

import AuthenticationClient

import Dependencies
import Networking

extension AuthenticationClient: DependencyKey {
    public static var liveValue: AuthenticationClient {
        AuthenticationClient(
            authentication: Self.authentication ,
            requestAuthentication: Self.requestAuthentication,
            removeAuthentication: { Void() }
        )
    }
}

fileprivate extension AuthenticationClient {
    static func authentication() throws -> Authentication {
        guard let accessToken = KeyChainStorage.shared.loadToken(forKey: "accessToken"),
           let refreshToken = KeyChainStorage.shared.loadToken(forKey: "refreshToken")
        else {
            throw AuthenticationClientError.tokenNotExists
        }
        return Authentication(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
    
    static func requestAuthentication(provider: String, code: String) async throws -> Authentication {
        @Dependency(\.basicLayer) var basicLayer
        let response: AuthenticationResponse = try await basicLayer.post(
            "xxxxxxxxxx",
            parameters: AuthenticationRequestParameter(
                provider: provider,
                code: code
            )
        )
        let _ = KeyChainStorage.shared.saveToken(response.accessToken, forKey: "accessToken")
        let _ = KeyChainStorage.shared.saveToken(response.refreshToken, forKey: "refreshToken")
        return Authentication(
            accessToken: response.accessToken,
            refreshToken: response.refreshToken
        )
    }
}
