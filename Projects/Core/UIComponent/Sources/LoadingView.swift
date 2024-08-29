//
//  LoadingView.swift
//  UIComponent
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation
import SwiftUI

import AppResource

import Lottie

public struct LoadingView: View {
    
    public init() {}
    
    public var body: some View {
        ZStack {
            ZStack {
                LottieView(
                    animation: .named("cuddle-loading", bundle: .appResource)
                ).configure {
                    $0.loopMode = .loop
                    $0.animationSpeed = 1
                }
                .playing()
            }
            .frame(width: 36, height: 36)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .zIndex(250)
    }
}
