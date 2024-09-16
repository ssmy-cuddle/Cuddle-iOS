//
//  ProfileNavigationView.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/25/24.
//

import Foundation
import SwiftUI

import UIComponent

import ComposableArchitecture
import NavigationTransitions

public struct ProfileNavigationView: View {
    
    @Bindable var store: StoreOf<ProfileNavigation>
    @EnvironmentObject var tabBarVisibility: TabBarVisibility

    public init(
        store: StoreOf<ProfileNavigation>
    ) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path),
            root: { Color.clear }
        ) { store in
            switch store.case {
            case let .main(store):
                ProfileView(store: store)
            case let .userProfile(store):
                UserProfileInputView(store: store)
            case let .cuddlerProfile(store):
                CuddlerProfileInputView(store: store)
            }
        }
        .onChange(of: store.path.count) { _, count in
            tabBarVisibility.isTabBarVisible = isTabBarVisible(count: count)
        }
    }
}

extension ProfileNavigationView {
    private func isTabBarVisible(count: Int) -> Bool {
        count < 2
    }
}
