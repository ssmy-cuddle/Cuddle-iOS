//
//  KakaoLoginButton.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 7/9/24.
//

import Foundation
import SwiftUI

import AppResource

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
    
    private let action: () -> Void
    
    public init(action: @escaping (() -> Void)) {
        self.action = action
    }
    
    public var body: some View {
        Button(
            action: action,
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
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.black)
                }
            }
        )
        .background(Color(red: 1, green: 0.9, blue: 0)) // FEE500
        .frame(maxWidth: .infinity, maxHeight: Metric.buttonHeight)
        .clipShape(.rect(cornerRadius: Metric.buttonCornerRadius))
    }
}
