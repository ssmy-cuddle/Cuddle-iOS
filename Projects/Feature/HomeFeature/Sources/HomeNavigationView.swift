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
    
    let store: StoreOf<HomeNavigation>
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    public init(store: StoreOf<HomeNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(
            store.scope(
                state: \.path, action: \.path
            )
        ) {
            Color.white
        } destination: { state in
            switch state {
            case .home:
                CaseLet(
                    /HomeNavigation.Path.State.home,
                    action: HomeNavigation.Path.Action.home,
                    then: HomeView.init(store:)
                )
                .navigationBarBackButtonHidden()
            }
        }
        
//        
//        NavigationStackStore(
//            store.scope(state: \.path, action: \.path),
//            root: {
////                HomeView(
////                    store: StoreOf<HomeFeature>(
////                        initialState: HomeFeature.State()
////                    ) {
////                        HomeFeature()
////                    }
////                )
//                Color.white
//            },
//            destination: { state in
//            switch state {
//            case .home:
//                CaseLet(
//                    state: /HomeNavigation.Path.State.addItem,
//                    action: HomeNavigation.Path.Action.addItem,
//                    then: HomeView.init(store:)
//                )
//            }
//        }
    }
}
