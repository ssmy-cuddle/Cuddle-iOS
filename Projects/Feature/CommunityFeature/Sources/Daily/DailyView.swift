//
//  DailyView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/5/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct DailyView: View {
    
    let store: StoreOf<Daily>
    
    public init(
        store: StoreOf<Daily>
    ) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            LazyVStack(spacing: 12) {
                ForEach(store.contents, id: \.id) { daily in
                    DailyContentView(
                        dailyContent: daily,
                        commentAction: { store.send(.view(.writeComment(daily.id))) },
                        likeAction: { store.send(.view(.like(daily.id, isLike: !daily.isLike))) }
                    )
                }
            }
        }
    }
}
