//
//  TravelPreviewView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/19/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TravelPreviewView: View {
    
    public init(store: StoreOf<TravelPreview>) {
        self.store = store
    }
    
    let store: StoreOf<TravelPreview>
    
    public var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(store.tarvels, id: \.id) {
                TravelPreviewContentView(travelPreview: $0)
            }
        }
    }
}
