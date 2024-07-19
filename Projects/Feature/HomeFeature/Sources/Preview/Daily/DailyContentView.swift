//
//  DailyContentView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/19/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture
import Kingfisher

public struct DailyContentView: View {
    
    let store: StoreOf<DailyContent>
    
    public init(store: StoreOf<DailyContent>) {
        self.store = store
    }
    
    // 두 개의 컬럼 정의
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    public var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(store.contents, id: \.id) { item in
                VStack(spacing: 10) {
                    DailyContentGridItemView(itemModel: item)
                }
            }
        }
    }
}

public struct DailyContentGridItemView: View {
    
    let itemModel: DailyContentGridItemModel
    
    public var body: some View {
        VStack {
            KFImage(itemModel.thumbnailURL)
                .resizable()
                .aspectRatio(140 / 129, contentMode: .fill)
                .clipped()
                .clipShape(.rect(cornerRadius: 6))
            
            Text(itemModel.title)
                .font(.pretendardBody12)
            
            HStack(spacing: 6) {
                KFImage(itemModel.profileImage)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .clipShape(.circle)
        
                Text(itemModel.nickname)
                    .font(.pretendardBody10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
