//
//  DiaryNavigationView.swift
//  DiaryFeature
//
//  Created by mvldev7 on 9/20/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct DiaryNavigationView: View {
    
    @Bindable private var store: StoreOf<DiaryNavigation>
    
    public init(store: StoreOf<DiaryNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path),
            root: { Color.clear }
        ) { store in
            switch store.case {
            case let .main(store):
                DiaryView(store: store)
                    .navigationBarHidden(true)
            }
        }
    }
}
