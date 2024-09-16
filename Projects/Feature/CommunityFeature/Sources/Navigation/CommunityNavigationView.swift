//
//  CommunityNavigationView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation
import SwiftUI

import AppResource
import UIComponent

import ComposableArchitecture

public struct CommunityNavigationView: View {
    
    @Bindable private var store: StoreOf<CommunityNavigation>
    @EnvironmentObject private var tabBarVisibility: TabBarVisibility
    
    public init(store: StoreOf<CommunityNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path),
            root: { Color.clear }
        ) { store in
            switch store.case {
            case let .main(store):
                CommunityView(store: store)
            case let .register(store):
                RegisterView(store: store)
            }
        }
        .sheet(item: $store.scope(state: \.comment, action: \.comment)) { store in
            CommentView(store: store)
        }
        .onChange(of: store.path.count) { _, count in
            tabBarVisibility.isTabBarVisible = isTabBarVisible(count: count)
        }
    }
}

extension CommunityNavigationView {
    private func isTabBarVisible(count: Int) -> Bool {
        count < 2
    }
}
