//
//  BannerView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation
import SwiftUI

import DesignSystem

import Kingfisher

import ComposableArchitecture

@Reducer
public struct Banner {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var banners: [BannerModel] = MockBanner.banners
        
        public init() {}
    }
}

public struct BannerView: View {
    
    let store: StoreOf<Banner>
    
    public init(store: StoreOf<Banner>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(Array(store.banners.enumerated()), id: \.offset) {
                        BannerContentView(banner: $0.element)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
    }
}

public struct BannerContentView: View {
    
    let banner: BannerModel
    
    public init(banner: BannerModel) {
        self.banner = banner
    }
    
    public var body: some View {
        KFImage(banner.imageURL)
            .resizable()
            .aspectRatio(290 / 71, contentMode: .fit)
            .clipShape(.rect(cornerRadius: 8))
    }
}
