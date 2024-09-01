//
//  CommunityNavigationView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct CommunityNavigationView: View {
    
    @State var store: StoreOf<CommunityNavigation>
    @State private var sheetHeight: CGFloat = .zero
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    public init(store: StoreOf<CommunityNavigation>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            NavigationLink(state: CommunityNavigation.Path.State.main(.init())) {
                Rectangle()
            }
        } destination: { store in
            switch store.state {
            case .main:
                if let store = store.scope(state: \.main, action: \.navigateToMainView) {
                    CommunityView(store: store)
                        .padding(.top, safeAreaInsets.top)
                        .navigationBarBackButtonHidden()
                        .sheet(
                            isPresented: .constant(self.store.isCommentPresent)
                        ) {
                            CommentView(
                                store: StoreOf<Comment>(
                                    initialState: Comment.State()
                                ) {
                                    Comment()
                                }
                            )
                            .onDisappear {
                                self.store.send(.commentDismissed)
                            }
                            .presentationDetents([.medium, .large])
                        }
                }
                
            case .register:
                if let store = store.scope(state: \.register, action: \.navigateToRegister) {
                    RegisterView(store: store)
                        .padding(.top, safeAreaInsets.top)
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
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
