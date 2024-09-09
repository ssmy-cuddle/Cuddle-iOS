//
//  ProfileNavigationView.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/25/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct ProfileNavigationView: View {
    
    let store: StoreOf<ProfileNavigation>
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    public init(store: StoreOf<ProfileNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(
            store.scope(state: \.path, action: \.path),
            root: { Color.white }
        ) { store in
            switch store.state {
            case .main:
                if let store = store.scope(state: \.main, action: \.main) {
                    ProfileView(store: store)
                        .navigationBarBackButtonHidden()
                }
            case .input:
                if let store = store.scope(state: \.input, action: \.input) {
                    CuddlerProfileInputView(store: store)
                        .padding(.top, safeAreaInsets.top)
                        .navigationBarBackButtonHidden()
                }
            case .userProfile:
                if let store = store.scope(state: \.userProfile, action: \.userProfile) {
                    UserProfileInputView(store: store)
                        .padding(.top, safeAreaInsets.top)
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
//
//        
//        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
//            Rectangle()
//        } destination: { store in
//            switch store.state {
//            case .main:
//                if let store = store.scope(state: \.main, action: \.main) {
//                    ProfileView(store: store)
//                        .navigationBarBackButtonHidden()
//                }
//            case .input:
//                if let store = store.scope(state: \.input, action: \.input) {
//                    CuddlerProfileInputView(store: store)
//                        .padding(.top, safeAreaInsets.top)
//                        .navigationBarBackButtonHidden()
//                }
//            case .userProfile:
//                if let store = store.scope(state: \.userProfile, action: \.userProfile) {
//                    UserProfileInputView(store: store)
//                        .padding(.top, safeAreaInsets.top)
//                        .navigationBarBackButtonHidden()
//                }
//            }
//        }
//    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
