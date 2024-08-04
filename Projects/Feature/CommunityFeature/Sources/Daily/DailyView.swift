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
    
    public init(store: StoreOf<Daily>) {
        self.store = store
    }
    
    public var body: some View {
        LazyVStack(spacing: 12) {
            ForEach(store.dailys, id: \.id) {
                DailyContentView(dailyContent: $0)
            }
        }
    }
}
