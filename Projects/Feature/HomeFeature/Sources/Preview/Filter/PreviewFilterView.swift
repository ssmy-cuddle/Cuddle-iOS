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
    
    public init(store: StoreOf<PreviewFilter>) {
        self.store = store
    }
    
    public var body: some View {
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
    }
}
