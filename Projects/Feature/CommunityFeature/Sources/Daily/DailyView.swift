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
                ForEach(store.contents, id: \.id) {
                    DailyContentView(
                        dailyContent: $0,
                        commentAction: { store.send(.view(.writeComment)) }
                    )
                }
            }
        }
//        .onAppear { store.send(.view(.onAppear)) }
    }
}
