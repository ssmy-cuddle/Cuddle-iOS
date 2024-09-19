//
//  AuthenticationView.swift
//  AuthenticationFeature
//
//  Created by mvldev7 on 7/8/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem

import AuthenticationClient

import ComposableArchitecture

public struct AuthenticationView: View {
        
    private enum Metric {
        static let buttonContainerSpacing = 8.0
        static let buttonContainerPadding = 22.0
        static let titleLabelFontSize = 44.0
    }
    
    private enum Message {
        static let cuddleTitle = "Cuddle"
        static let cuddleDescription = "발에서 마음까지"
    }
    
    private let store: StoreOf<AuthenticationFeature>
    
    public init(store: StoreOf<AuthenticationFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image(asset: AppResourceAsset.Image.cuddleMainLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 118)
                
                Text(Message.cuddleTitle)
                    .font(
                        .custom(
                            NPS.header.name,
                            size: Metric.titleLabelFontSize
                        )
                    )
                    .padding(.top, -8)
                
                Text(Message.cuddleDescription)
                    .font(.pretendardBody12)
                    .contentMargins(.top, 8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: Metric.buttonContainerSpacing) {
                KakaoLoginButton(action: {
                    store.send(.view(.appleLoginRequested(identifier: "???????")))
                })
                AppleLoginButton {
                    store.send(.view(.appleLoginRequested(identifier: $0)))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Metric.buttonContainerPadding)
        }
        .safeAreaPadding(.vertical)
        .padding(.vertical, 16)
    }
}
