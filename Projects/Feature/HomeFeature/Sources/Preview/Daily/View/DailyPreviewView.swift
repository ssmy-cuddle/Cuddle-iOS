//
//  DailyPreviewView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/19/24.
//

import Foundation
import SwiftUI

import DesignSystem

import ComposableArchitecture
import Kingfisher

public struct DailyPreviewView: View {
    
    private let store: StoreOf<DailyPreviewFeature>
    
    public init(store: StoreOf<DailyPreviewFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            VStack(alignment: .leading, spacing: 8) {
                titleText
                dailyView(dailys: store.dailys)
            }
        }
    }
}

extension DailyPreviewView {
    
    @ViewBuilder private var titleText: some View {
        Text("우리들의 일상")
            .font(.npsTitle16)
    }
    
    @ViewBuilder private func dailyView(dailys: [DailyPreviewModel]) -> some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(dailys, id: \.id) { daily in
                VStack(spacing: 10) {
                    DailyPreviewItemView(daily: daily)
                }
            }
        }
    }
}
