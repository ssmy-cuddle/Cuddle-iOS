//
//  PreviewFilterView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct PreviewFilterView: View {
    
    let store: StoreOf<PreviewFilter>
    
    let dailyContentView = DailyContentView(
        store: StoreOf<DailyContent>(
            initialState: DailyContent.State()
        ) {
            DailyContent()
        }
    )
    
    public init(store: StoreOf<PreviewFilter>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(store.previewFilters, id: \.hashValue) { previewType in
                        PreviewFilterContentView(
                            previewType: previewType,
                            isSelected: previewType == store.selectedPreviewType
                        )
                        .onTapGesture { _ in
                            store.send(.selectPreviewType(previewType))
                        }
                    }
                }
            }
            switch store.selectedPreviewType {
            case .daily:
                DailyContentView(
                    store: StoreOf<DailyContent>(
                        initialState: DailyContent.State()
                    ) {
                        DailyContent()
                    }
                )
            case .travels:
                Text("여행기")
            case .cuddlers:
                Text("Cuddle 동물들")
            }
        }
    }
}
