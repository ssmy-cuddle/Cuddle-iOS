//
//  AuthorizationToken.swift
//  Networking
//
//  Created by mvldev7 on 9/27/24.
//

import Foundation

public struct AuthorizationToken {
    public let accessToken: String
    public let refreshToken: String
    
    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

extension AuthorizationToken: Decodable {}
