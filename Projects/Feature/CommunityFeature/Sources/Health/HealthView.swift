//
//  HealthView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/14/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct HealthView: View {
    
    let store: StoreOf<Health>
    
    public init(store: StoreOf<Health>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            LazyVStack(spacing: 8) {
                ForEach(store.contents, id: \.id) {
                    HealthContentView(healthContent: $0)
                }
            }
        }
    }
}
