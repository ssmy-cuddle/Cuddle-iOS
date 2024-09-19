//
//  KakaoLoginButton.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 7/9/24.
//

import Foundation
import SwiftUI

import AppResource

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

public struct KakaoLoginButton: View {
    
    private enum Metric {
        static let iconImageSize = 16.0
        static let iconImageLeading = 20.0
        
        static let buttonHeight = 44.0
        static let buttonCornerRadius = 8.0
    }
    
    private enum Message {
        static let kakaoLogin = "카카오 로그인"
    }
    
    private let action: (String) -> Void
    
    public init(action: @escaping ((String) -> Void)) {
        self.action = action
    }
    
    public var body: some View {
        Button(
            action: { proceedKakaoLogin() },
            label: {
                ZStack {
                    Image(asset: AppResourceAsset.Image.loginKakaoLogo)
                        .resizable()
                        .frame(
                            width: Metric.iconImageSize,
                            height: Metric.iconImageSize,
                            alignment: .center
                        )
                        .position(x: Metric.iconImageLeading, y: Metric.buttonHeight / 2)
                        .foregroundStyle(.white)
                    
                    Text(Message.kakaoLogin)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.black)
                }
            }
        )
        .background(Color(red: 1, green: 0.9, blue: 0)) // FEE500
        .frame(maxWidth: .infinity, maxHeight: Metric.buttonHeight)
        .clipShape(.rect(cornerRadius: Metric.buttonCornerRadius))
    }
    
    private func proceedKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            //카카오톡이 설치되어있다면 카카오톡을 통한 로그인 진행
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let idToken = oauthToken?.idToken  {
                    action(idToken)
                } else {
                    print(error)
                }
            }
        } else {
            //카카오톡이 설치되어있지 않다면 사파리를 통한 로그인 진행
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let idToken = oauthToken?.idToken  {
                    action(idToken)
                } else {
                    print(error)
                }
            }
        }
    }
}
