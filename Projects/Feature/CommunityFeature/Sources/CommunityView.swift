//
//  CommunityView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/1/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem
import UIComponent

// TODO: Feature 간 의존성 분리하기
import HomeFeature

import ComposableArchitecture

public struct CommunityView: View {
    
    private let store: StoreOf<CommunityFeature>
    
    @EnvironmentObject private var tabBarVisibility: TabBarVisibility
    
    public init(store: StoreOf<CommunityFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            if store.isLoading {
                LoadingView()
                    .navigationBarTitle("", displayMode: .inline) //this must be empty
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            } else {
                GeometryReader { proxy in
                    ZStack(alignment: .top) {
                        registerButtonView(
                            onTapRegisterButton: { store.send(.view(.registerButtonTapped)) }
                        )
                        
                        ScrollView {
                            ZStack(alignment: .top) {
                                backgroundImageView
                                VStack(alignment: .leading) {
                                    titleTextView
                                    BannerView(
                                        store: StoreOf<Banner>(
                                            initialState: Banner.State()
                                        ) {
                                            Banner()
                                        }
                                    )
                                    .aspectRatio(290 / 71, contentMode: .fit)
                                    .padding(.horizontal, 16)
                                    
                                    contentView(for: .daily)
                                }
                            }
                        }
                        .clipped()
                        .refreshable {
                            await store.send(.view(.refresh))
                                .finish()
                        }
                    }
//                    .navigationBarTitle("", displayMode: .inline)
//                    .navigationBarHidden(true)
//                    .navigationBarBackButtonHidden(true)
                }
            }
        }
        .onAppear {
            store.send(.view(.onAppear))
//            tabBarVisibility.isTabBarVisible = true
        }
        .navigationBarTitle("", displayMode: .inline) //this must be empty
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension CommunityView {
    
    @ViewBuilder
    private var loadingView: some View {
        LoadingView()
    }
    
    @ViewBuilder private func registerButtonView(
        onTapRegisterButton: @escaping () -> Void
    ) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .shadow(color: .black.opacity(0.25), radius: 20, x: 10, y: 10)
                    
                    Button(action: { onTapRegisterButton() } ) {
                        AppResourceAsset.Image.icRegister.swiftUIImage
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                    .frame(width: 50, height: 50)
                    .background(AppResourceAsset.Color.lubbyBlue.swiftUIColor)
                    .clipShape(.circle)
                    .shadow(
                        color: Color(red: 0.6, green: 0.68, blue: 0.85).opacity(0.25),
                        radius: 4,
                        x: .zero,
                        y: 4
                    )
                }
            }
        }
        .zIndex(20)
        .padding()
    }
    
    @ViewBuilder private var backgroundImageView: some View {
        AppResourceAsset.Image.cuddleCommunityBackground.swiftUIImage
            .frame(height: 135, alignment: .top)
            .aspectRatio(472 / 448, contentMode: .fit)
            .clipped()
        
    }
    
    @ViewBuilder private var titleTextView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Cuddle")
                    .font(.custom(NPS.header.name, size: 20))
                Text("커뮤니티")
                    .font(.custom(NPS.header.name, size: 26))
            }
        }
        .padding(.horizontal, 28)
        .padding(.top, 38)
    }
    
    @ViewBuilder
    public func contentView(for category: CommunityCategoryType) -> some View {
        switch category {
        case .daily:
            VStack {
                DailyView(
                    store: store.scope(state: \.daily, action: \.daily)
                )
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 16)
            }
        default:
            Text("Not Implements")
        }
    }
}
