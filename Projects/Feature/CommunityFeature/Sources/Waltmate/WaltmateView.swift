//
//  WaltmateView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/18/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct WaltmateView: View {
    
    let store: StoreOf<Waltmate>
    
    public init(store: StoreOf<Waltmate>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            LazyVStack(spacing: 2) {
                ForEach(store.contents, id: \.id) {
                    WaltmateContentView(waltmate: $0)
                }
            }
        }
    }
}
