//
//  HomeNavigationView.swift
//  HomeFeature
//
//  Created by mvldev7 on 9/9/24.
//

import Foundation
import SwiftUI

import UIComponent

import ComposableArchitecture

public struct HomeNavigationView: View {
    
    @Bindable var store: StoreOf<HomeNavigation>
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    public init(store: StoreOf<HomeNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path),
            root: { Color.clear }
        ) { store in
            switch store.case {
            case let .home(store):
                HomeView(store: store)
            }
        }
    }
}
