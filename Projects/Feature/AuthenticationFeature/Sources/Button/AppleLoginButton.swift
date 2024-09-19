//
//  AppleLoginButton.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 7/9/24.
//

import Foundation
import SwiftUI

import AuthenticationClient
import AuthenticationServices

import AppResource

public struct AppleLoginButton: View {
    
    private enum Metric {
        static let iconImageSize = 16.0
        static let iconImageLeading = 20.0

        static let buttonHeight = 44.0
        static let buttonCornerRadius = 8.0
    }
    
    private enum Message {
        static let appleLogin = "Apple로 로그인"
    }
    
    private let action: (String) -> Void
    
    public init(action: @escaping ((String) -> Void)) {
        self.action = action
    }
    
    public var body: some View {
        Button(
            action: {},
            label: {
                ZStack {
                    Text("")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.black)
                        .position(.init(x: 20, y: 22))
                    
                    Text(Message.appleLogin)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.black)
                }
            }
        )
        .background(.white)
        .clipShape(.rect(cornerRadius: Metric.buttonCornerRadius))
        .frame(maxWidth: .infinity, maxHeight: Metric.buttonHeight)
        .overlay {
            SignInWithAppleButton(
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case let .success(authorizationResult):
                        print("Apple Login Successful")
                        switch authorizationResult.credential{
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            // 계정 정보 가져오기
//                            let userIdentifier = appleIDCredential.user
//                            let fullName = appleIDCredential.fullName
//                            let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
//                            let email = appleIDCredential.email
//                            let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                            let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)!
                            action(authorizationCode)
                        default:
                            break
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        print("error")
                    }
                }
            )
            .blendMode(.overlay)
        }
        .overlay(
            RoundedRectangle(
                cornerRadius: Metric.buttonCornerRadius
            )
            .stroke(Color(red: 0.75, green: 0.75, blue: 0.75), lineWidth: 1)
        )
    }
}
