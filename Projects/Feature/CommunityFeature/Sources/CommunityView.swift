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

import ComposableArchitecture

public struct CommunityView: View {
    
    public init() {}
    
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
                    .padding(.top, 38)
                    
                    LazyVStack(
                        pinnedViews: [.sectionHeaders]
                    ) {
                        Section(
                            header:
                                CommunityCategoryView(
                                    store: StoreOf<Community>(
                                        initialState: Community.State()
                                    ) {
                                        Community()
                                    }
                                )
                                .zIndex(4)
                        ) {
                            ForEach(1...70, id: \.self) { count in
                                /*@START_MENU_TOKEN@*/Text("Placeholder \(count)")/*@END_MENU_TOKEN@*/
                            }
                            .zIndex(1)
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
    
    init(store: StoreOf<Community>) {
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
