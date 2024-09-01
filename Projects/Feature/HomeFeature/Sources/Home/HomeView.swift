//
//  HomeView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/17/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem

import ComposableArchitecture

public struct HomeView: View {
    
    let store: StoreOf<Home>
    
    @State private var offset: CGFloat = Metric.headerViewHeight {
        didSet {
            backgroundAlpha = offset / Metric.headerViewHeight
        }
    }
    @State private var backgroundAlpha = 1.0
    
    private enum Metric {
        static let headerViewHeight = 151.0
    }
    
    private var scrollObservableView: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: ScrollOffsetKey.self,
                    value: proxy.frame(in: .global).minY
                )
        }
        .frame(height: 0)
    }
    
    
    
    private let previewView: some View = PreviewFilterView(
        store: StoreOf<PreviewFilter>(
            initialState: PreviewFilter.State()
        ) {
            PreviewFilter()
        }
    )
    .padding(.horizontal, 16)
    .padding(.vertical, 20)
    
    public init(store: StoreOf<Home>) {
        self.store = store
//        UIRefreshControl().layer.zPosition = 1000
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section(
                        header: HomeHeaderView(opacity: .constant(CGFloat(backgroundAlpha)))
                            .opacity(backgroundAlpha)
                    ) {
                        scrollObservableView
                        VStack {
                            originalView
                                .padding(.top, 28)
                            bannerView
                            previewView
                        }
                        .background(.white)
                        .zIndex(3)
                        .clipShape(.rect(cornerRadius: 30))
                        .clipped()
                    }
                    
                }
            }
            .onPreferenceChange(ScrollOffsetKey.self) { offset = $0 }
            .refreshable {
                await store.send(.original(.view(.onAppear)))
                    .finish()
            }
        }
    }
}

extension HomeView {
    
//    private var previewView: some View {
//        Preview
//    }
//    
    
    private var originalView: some View {
        OriginalView(
            store: store.scope(state: \.original, action: \.original)
        )
    }
    
    private var bannerView: some View {
        BannerView(
            store: StoreOf<Banner>(
                initialState: Banner.State()
            ) {
                Banner()
            }
        )
        .aspectRatio(290 / 71, contentMode: .fit)
        .padding(.horizontal, 16)
        .padding(.top, 20)
    }
}




public struct HomeHeaderView: View {
    
    @Binding private var opacity: CGFloat
    
    public init(opacity: Binding<CGFloat>) {
        self._opacity = opacity
    }
    
    public var body: some View {
        AppResourceAsset.Image.cuddleHomeBackground.swiftUIImage
            .resizable()
            .aspectRatio(320 / 269, contentMode: .fill)
            .frame(height: 100, alignment: .center)
            .opacity(opacity)
            .overlay {
                HStack(alignment: .center, spacing: 16) {
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
            }
    }
}


struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
