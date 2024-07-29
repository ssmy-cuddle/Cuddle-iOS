//
//  ProfileContentView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/29/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct ProfilePreviewView: View {
    
    let store: StoreOf<ProfilePreview>
    
    public init(store: StoreOf<ProfilePreview>) {
        self.store = store
    }
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    public var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 8) {
                ForEach(store.contents, id: \.id) { profile in
                    HStack(spacing: 10) {
                        ProfilePreviewContentView(profile: profile)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
