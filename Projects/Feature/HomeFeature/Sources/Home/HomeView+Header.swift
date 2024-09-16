//
//  HomeView+Header.swift
//  HomeFeature
//
//  Created by mvldev7 on 9/5/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem

public struct HomeHeaderView: View {
    
    @Binding private var opacity: CGFloat
    
    public init(opacity: Binding<CGFloat>) {
        self._opacity = opacity
    }
    
    public var body: some View {
        AppResourceAsset.Image.homeBackgroundWithAlpha.swiftUIImage
            .resizable()
            .aspectRatio(320 / 476, contentMode: .fill)
            .frame(height: 112, alignment: .bottom)
            .padding(.bottom, -16)
            .overlay {
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("발에서 마음까지")
                            .font(.npsBody10)
                        Text("Cuddle")
                            .font(.custom(NPS.title.name, size: 25))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    AppResourceAsset.Image.cuddleMainLogo.swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 81, height: 53)
                }
                .padding(.leading, 24)
                .padding(.trailing, 14)
                .frame(maxHeight: .infinity)
            }
            .opacity(opacity)
    }
}
