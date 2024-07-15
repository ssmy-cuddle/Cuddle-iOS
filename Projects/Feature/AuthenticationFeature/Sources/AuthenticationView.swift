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
    
    private let store: StoreOf<Authentication>
    
    public init(store: StoreOf<Authentication>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            VStack(alignment: .center) {
//                GeometryReader { geometry in
                    Image(asset: AppResourceAsset.Image.cuddleMainLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.4)
                    
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
//                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: Metric.buttonContainerSpacing) {
                KakaoLoginButton(action: {})
                AppleLoginButton(action: {})
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Metric.buttonContainerPadding)
        }
        .safeAreaPadding(.vertical)
        .padding(.vertical, 16)
    }
}
