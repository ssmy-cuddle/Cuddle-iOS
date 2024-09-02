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
    
    let store: StoreOf<Community>
    
    public init(store: StoreOf<Community>) {
        self.store = store
    }
    
    let categoryStore = StoreOf<CommunityCategory>(
        initialState: CommunityCategory.State()
    ) {
        CommunityCategory()
    }
    
    let travelPreviewStore = StoreOf<TravelPreview>(initialState: TravelPreview.State()) {
        TravelPreview()
    }
    
    let dailyStore = StoreOf<Daily>(
        initialState: Daily.State()
    ) {
        Daily()
    }
    
    let healthStore = StoreOf<Health>(
        initialState: Health.State()
    ) {
        Health()
    }
    
    let waltmateStore = StoreOf<Waltmate>(
        initialState: Waltmate.State()
    ) {
        Waltmate()
    }
    
    @ViewBuilder
    public func buildContentView(category: CommunityCategoryType) -> some View {
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
        case .travel:
            TravelPreviewView(
                store: travelPreviewStore
            )
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 16)
        case .walkmate:
            WaltmateView(
                store: waltmateStore
            )
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 16)
            
        case .health:
            HealthView(
                store: healthStore
            )
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 16)
        }
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            ZStack {
                if store.isLoading {
                    LoadingView()
                } else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .shadow(color: .black.opacity(0.25), radius: 20, x: 10, y: 10)
                                
                                Button(action: { store.send(.register)} ) {
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
                    
                    ScrollView {
                        ZStack(alignment: .top) {
                            AppResourceAsset.Image.cuddleCommunityBackground.swiftUIImage
                                .frame(height: 100, alignment: .top)
                                .aspectRatio(472 / 448, contentMode: .fit)
                            
                            VStack(alignment: .leading) {
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
                                
                                VStack {
                                    
                                    //                                LazyVStack(
                                    //                                    pinnedViews: [.sectionHeaders]
                                    //                                ) {
                                    //                                    Section(
                                    //                                        header: CommunityCategoryView(store: categoryStore)
                                    //                                    ) {

                                    
                                    BannerView(
                                        store: StoreOf<Banner>(
                                            initialState: Banner.State()
                                        ) {
                                            Banner()
                                        }
                                    )
                                    .aspectRatio(290 / 71, contentMode: .fit)
                                    .padding(.horizontal, 16)
                                    
                                    buildContentView(category: categoryStore.selectedCategory)

                                }
                                
                            }
                        }
                    }
                    .clipped()
                    .refreshable {
                        await store.send(.daily(.delegate(.refresh)))
                            .finish()
                    }
                }
            }
            .onAppear {
                store.send(.daily(.view(.onAppear)))
            }
        }
    }
}

public struct CommunityCategoryView: View {
    
    let store: StoreOf<CommunityCategory>
    
    public init(store: StoreOf<CommunityCategory>) {
        self.store = store
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    let totalSpacing = geometry.size.width - 24 - (56.0 * CGFloat(store.categories.count))
                    HStack(spacing: totalSpacing / (CGFloat(store.categories.count - 1))) {
                        ForEach(store.categories, id: \.hashValue) { category in
                            CommunityCategoryContentView(
                                category: category,
                                isSelected: store.selectedCategory == category
                            )
                            .onTapGesture {
                                store.send(.changeCategory(category))
                            }
                        }
                        .frame(width: 56, alignment: .bottom)
                    }
                }
                .safeAreaInset(edge: .leading, spacing: 0) { Color.clear.frame(width: 12) }
                .safeAreaInset(edge: .trailing, spacing: 0) { Color.clear.frame(width: 12) }
                
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(Color(red: 0.52, green: 0.52, blue: 0.52))
            }
            .background(.white)
        }
        .zIndex(10)
    }
}

public struct CommunityCategoryContentView: View {
    
    let category: CommunityCategoryType
    let isSelected: Bool
    
    public init(
        category: CommunityCategoryType,
        isSelected: Bool
    ) {
        self.category = category
        self.isSelected = isSelected
    }
    
    public var body: some View {
        VStack {
            category.icon
                .frame(width: 34, height: 34, alignment: .center)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(category.tintColor)
            
            Text(category.title)
                .font(.npsTitle12)
                .padding(.top, 8)
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1.5, alignment: .bottom)
                .foregroundStyle(isSelected ? .black : .clear)
                .padding(.top, 8)
        }
    }
}
