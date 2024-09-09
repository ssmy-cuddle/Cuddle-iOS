//
//  OriginalView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation
import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct OriginalView: View {
    
    let store: StoreOf<OriginalFeature>
    
    public init(store: StoreOf<OriginalFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            originalView(store.originals)
        }
    }
}

extension OriginalView {
    
    @ViewBuilder
    private func originalView(_ originals: [OriginalContentModel]) -> some View {
        VStack(alignment: .leading) {
            Text("Cuddle Originals")
                .font(.npsHeader16)
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(originals) {
                        OriginalContentView(content: $0)
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 16)
        }
    }
}
