//
//  SocialLoginProvider.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 9/19/24.
//

import Foundation

public enum SocialLoginProvider {
    case apple
    case kakao
    
    public var value: String {
        switch self {
        case .apple: "apple"
        case .kakao: "kakao"
        }
    }
}
