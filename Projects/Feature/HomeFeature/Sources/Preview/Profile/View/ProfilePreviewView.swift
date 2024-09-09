//
//  ProfileContentView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/29/24.
//

import Foundation
import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct ProfilePreviewView: View {
    
    private let store: StoreOf<ProfilePreviewFeature>
    
    public init(store: StoreOf<ProfilePreviewFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            VStack(alignment: .leading, spacing: 8) {
                titleText
                profileView(profiles: store.profiles)
            }
        }
    }
}

extension ProfilePreviewView {
    
    @ViewBuilder private var titleText: some View {
        Text("Cuddle과 함께하는 동물들")
            .font(.npsTitle16)
            .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private func profileView(profiles: [ProfilePreviewModel]) -> some View {
        let rows = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 8) {
                ForEach(profiles, id: \.id) { profile in
                    HStack(spacing: 10) {
                        ProfilePreviewItemView(profile: profile)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 16)
    }
}
