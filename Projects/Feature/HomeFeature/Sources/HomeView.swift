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
    private enum Metric {
        static let headerViewHeight = 151.0
    }
    
    @State private var offset: CGFloat = Metric.headerViewHeight {
        didSet {
            backgroundAlpha = offset / Metric.headerViewHeight
        }
    }
    @State private var backgroundAlpha = 1.0
    
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
    
    public init() {}
    
    private let previewView: some View = PreviewFilterView(
        store: StoreOf<PreviewFilter>(
            initialState: PreviewFilter.State()
        ) {
            PreviewFilter()
        }
    )
    .padding(.horizontal, 16)
    .padding(.vertical, 20)
    
    public var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section(
                    header: HomeHeaderView()
                        .opacity(backgroundAlpha)
                ) {
                    scrollObservableView
                    VStack {
                        OriginalView(contents: MockOriginalContent.contents)
                            .padding(.top, 28)
                        
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
                        
                        previewView
                    }
                    .background(.white)
                    .zIndex(3)
                    .clipShape(.rect(cornerRadius: 30))
                    .clipped()
                }
                
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .onPreferenceChange(ScrollOffsetKey.self) {
            print("??????: \($0)")// 추가부분
            offset = $0
        }
    }
    
}

public struct HomeHeaderView: View {
    public var body: some View {
        AppResourceAsset.Image.cuddleHomeBackground.swiftUIImage
            .resizable()
            .aspectRatio(320 / 269, contentMode: .fill)
            .zIndex(1)
            .frame(height: 151, alignment: .center)
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
                .padding(.top, 24)
            }
    }
}


struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
