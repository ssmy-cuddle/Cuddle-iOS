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

// TODO: Feature 간 의존성 분리하기
import HomeFeature

import ComposableArchitecture

public struct CommunityView: View {
    
    public init() {}
    
    let categoryStore = StoreOf<Community>(
        initialState: Community.State()
    ) {
        Community()
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
    
    @ViewBuilder
    public func buildContentView(category: CommunityCategory) -> some View {
        switch category {
        case .daily:
            DailyView(
                store: dailyStore
            )
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 16)
        case .travel:
            TravelPreviewView(
                store: travelPreviewStore
            )
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 16)
        case .walkmate:
            ForEach(1...70, id: \.self) { count in
                /*@START_MENU_TOKEN@*/Text("Placeholder \(count)")/*@END_MENU_TOKEN@*/
            }
            .zIndex(1)
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
        ScrollView {
            ZStack(alignment: .top) {
                AppResourceAsset.Image.cuddleCommunityBackground.swiftUIImage
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
                    .padding(.vertical, 38)
                    
                    LazyVStack(
                        pinnedViews: [.sectionHeaders]
                    ) {
                        Section(
                            header: CommunityCategoryView(store: categoryStore)
                        ) {
                            BannerView(
                                store: StoreOf<Banner>(
                                    initialState: Banner.State()
                                ) {
                                    Banner()
                                }
                            )
                            .aspectRatio(290 / 71, contentMode: .fit)
                            .padding(.horizontal, 16)
                            .padding(.top, 90)
                            
                            buildContentView(category: categoryStore.selectedCategory)
                        }
                    }
                    
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .clipped()
    }
}

public struct CommunityCategoryView: View {
    
    let store: StoreOf<Community>
    
    public init(store: StoreOf<Community>) {
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
    
    let category: CommunityCategory
    let isSelected: Bool
    
    public init(
        category: CommunityCategory,
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
