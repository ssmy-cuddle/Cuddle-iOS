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
import UIComponent

import ComposableArchitecture

public struct HomeView: View {
    
    private enum Metric {
        static let headerViewHeight = 110.0
    }

    @State private var headerViewOpacity: CGFloat = 1.0
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    private let store: StoreOf<HomeFeature>

    public init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            if store.isSkeletonLoading {
                HomeSkeletonView()
                    .padding(.top, 24)
            } else {
                ZStack {
                    ScrollView {
                        LazyVStack(
                            pinnedViews: [.sectionHeaders]
                        ) {
                            Section(
                                header: HomeHeaderView(opacity: $headerViewOpacity)
                            ) {
                                ScrollObserverableView()
                                VStack(spacing: 28) {
                                    originalView
                                    
                                    bannerView
                                        .padding(.horizontal, 16)
                                    
                                    dailyPreviewView
                                        .padding(.horizontal, 16)
                                    
                                    profilePreviewView
                                }
                                .padding(.vertical, 28)
                                .background(.white)
                                .zIndex(3)
                                .clipShape(.rect(cornerRadius: 30))
                            }
                        }
                    }
                    .refreshable {
                        await store.send(.view(.refresh)).finish()
                    }
                    .onPreferenceChange(ScrollOffsetKey.self) { offset in
                        headerViewOpacity = offset / Metric.headerViewHeight
                    }
                }
            }
        }
        .onAppear { store.send(.view(.onAppear)) }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension HomeView {

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
    }
    
    private var dailyPreviewView: some View {
        DailyPreviewView(
            store: store.scope(state: \.daily, action: \.daily)
        )
    }
    
    private var profilePreviewView: some View {
        ProfilePreviewView(
            store: store.scope(state: \.profile, action: \.profile)
        )
    }
}

public struct BlinkViewModifier: ViewModifier {
    let duration: Double
    @State private var blinking: Bool = false
    
    public func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0.3 : 1)
            .animation(.easeInOut(duration: duration).repeatForever(), value: blinking)
            .onAppear {
                // Animation will only start when blinking value changes
                blinking.toggle()
            }
    }
}

extension View {
    func blinking(duration: Double = 1) -> some View {
        modifier(BlinkViewModifier(duration: duration))
    }
}
struct SkeletonCellView: View {
    let primaryColor = Color(.init(gray: 0.9, alpha: 1.0))
    let secondaryColor  = Color(.init(gray: 0.8, alpha: 1.0))
    
    var body: some View {
        primaryColor
    }
}
