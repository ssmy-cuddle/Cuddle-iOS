//
//  BannerView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation
import SwiftUI

import DesignSystem

public struct BannerView: View {
    
    private let banners: [BannerModel]
    
    public init(banners: [BannerModel]) {
        self.banners = banners
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(Array(banners.enumerated()), id: \.offset) {
                    BannerContentView(banner: $0.element)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
    }
}

public struct BannerContentView: View {
    
    let banner: BannerModel
    
    public init(banner: BannerModel) {
        self.banner = banner
    }
    
    public var body: some View {
        banner.image
            .resizable()
            .aspectRatio(290 / 71, contentMode: .fit)
            .clipShape(.rect(cornerRadius: 8))
    }
}
