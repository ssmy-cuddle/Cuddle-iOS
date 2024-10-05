//
//  AuthenticationRequestParameter.swift
//  AuthenticationClient
//
//  Created by mvldev7 on 9/28/24.
//

import Foundation

public struct AuthenticationRequestParameter: Encodable {
    public let provider: Provider?
    public let code: String
    
    init(provider: String, code: String) {
        self.provider = Provider(rawValue: provider)
        self.code = code
    }
    
    public enum Provider: String, Encodable {
        case apple
        case kakao
        
        public init?(rawValue: String) {
            self = switch rawValue {
            case "apple": Provider.apple
            case "kakao": Provider.kakao
            default: .apple
            }
        }
    }
}
