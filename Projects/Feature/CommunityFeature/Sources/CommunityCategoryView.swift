//
//  CommunityCategoryView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 9/15/24.
//

import Foundation


//public struct CommunityCategoryView: View {
//
//    let store: StoreOf<CommunityCategory>
//
//    public init(store: StoreOf<CommunityCategory>) {
//        self.store = store
//    }
//
//    public var body: some View {
//        GeometryReader { geometry in
//            VStack(spacing: 0) {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    let totalSpacing = geometry.size.width - 24 - (56.0 * CGFloat(store.categories.count))
//                    HStack(spacing: totalSpacing / (CGFloat(store.categories.count - 1))) {
//                        ForEach(store.categories, id: \.hashValue) { category in
//                            CommunityCategoryContentView(
//                                category: category,
//                                isSelected: store.selectedCategory == category
//                            )
//                            .onTapGesture {
//                                store.send(.changeCategory(category))
//                            }
//                        }
//                        .frame(width: 56, alignment: .bottom)
//                    }
//                }
//                .safeAreaInset(edge: .leading, spacing: 0) { Color.clear.frame(width: 12) }
//                .safeAreaInset(edge: .trailing, spacing: 0) { Color.clear.frame(width: 12) }
//
//                Rectangle()
//                    .frame(height: 0.5)
//                    .foregroundColor(Color(red: 0.52, green: 0.52, blue: 0.52))
//            }
//            .background(.white)
//        }
//        .zIndex(10)
//    }
//}
//
//public struct CommunityCategoryContentView: View {
//
//    let category: CommunityCategoryType
//    let isSelected: Bool
//
//    public init(
//        category: CommunityCategoryType,
//        isSelected: Bool
//    ) {
//        self.category = category
//        self.isSelected = isSelected
//    }
//
//    public var body: some View {
//        VStack {
//            category.icon
//                .frame(width: 34, height: 34, alignment: .center)
//                .aspectRatio(1, contentMode: .fit)
//                .foregroundStyle(category.tintColor)
//
//            Text(category.title)
//                .font(.npsTitle12)
//                .padding(.top, 8)
//
//            Rectangle()
//                .frame(maxWidth: .infinity)
//                .frame(height: 1.5, alignment: .bottom)
//                .foregroundStyle(isSelected ? .black : .clear)
//                .padding(.top, 8)
//        }
//    }
//}
