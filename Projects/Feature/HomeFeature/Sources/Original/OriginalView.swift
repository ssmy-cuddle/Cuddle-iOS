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
    
    let store: StoreOf<Original>
    
    public init(store: StoreOf<Original>) {
        self.store = store
    }
    
    public var body: some View {
        
        WithViewStore(store, observe: { $0 }) { store in
            VStack(alignment: .leading) {
                Text("Cuddle Originals")
                    .font(.npsHeader16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 12) {
                        ForEach(store.contents) {
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
            .onAppear { store.send(.view(.onAppear)) }
        }
    }
}
