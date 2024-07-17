//
//  AppleLoginButton.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 7/9/24.
//

import Foundation
import SwiftUI

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
    
    private let action: () -> Void
    
    public init(action: @escaping (() -> Void)) {
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
        .overlay(
            RoundedRectangle(
                cornerRadius: Metric.buttonCornerRadius
            )
            .stroke(Color(red: 0.75, green: 0.75, blue: 0.75), lineWidth: 1)
        )
    }
}
