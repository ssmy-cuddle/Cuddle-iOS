//
//  Authentication.swift
//  AuthenticationClient
//
//  Created by mvldev7 on 9/19/24.
//

import Foundation

public struct Authentication {
    public let accessToken: String
    public let refreshToken: String
    
    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

extension Authentication: Equatable {}
