//
//  Authentication.swift
//  AuthenticationClient
//
//  Created by mvldev7 on 9/19/24.
//

import Foundation

public struct Authentication {
    public let token: String
    
    public init(token: String) {
        self.token = token
    }
}

extension Authentication: Equatable {}
