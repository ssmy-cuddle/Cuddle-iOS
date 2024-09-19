import SwiftUI

import AppResource
import DesignSystem

import AuthenticationFeature

import ComposableArchitecture

//class AppState: ObservableObject {
//    @Published var isLoggedIn: Bool = false
//}

@main
struct CuddleApp: App {
    
    let store = StoreOf<CuddleAppFeature>(
        initialState: CuddleAppFeature.State()
    ) {
        CuddleAppFeature()
    }
    
    let contentView: ContentView
    let authorizationView = AuthenticationView(
        store: StoreOf<AuthenticationFeature>(
            initialState: AuthenticationFeature.State()
        ) {
            AuthenticationFeature()
        }
    )
    
    //    @StateObject var appState = AppState()
    
    init() {
        self.contentView = ContentView(
            store: StoreOf<Content>(
                initialState: Content.State()
            ) {
                Content()
            }
        )
        registerCustomFonts()
        configureRefreshControl()
    }
    
    var body: some Scene {
        WithPerceptionTracking {
            WindowGroup {
                switch store.visibility {
                case .authentication:
                    AuthenticationView(
                        store: store.scope(state: \.authentication, action: \.authentication)
                    )
                case .content:
                    ContentView(
                        store: store.scope(state: \.content, action: \.content)
                    )
                }
            }
        }
    }
    
    private func registerCustomFonts() {
        Font.customFonts.forEach { $0.register() }
    }
    
    private func configureRefreshControl() {
        UIRefreshControl.appearance().tintColor = AppResourceAsset.Color.lubbyBlue.color
    }
}
