import SwiftUI

import AppResource
import DesignSystem

import AuthenticationFeature

import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKCommon

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
        registerKakaoSDK()
    }
    
    var body: some Scene {
        WithPerceptionTracking {
            WindowGroup {
                ZStack {
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
                .onOpenURL(perform: { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        let _ = AuthController.handleOpenUrl(url: url)
                    }
                })
            }
        }
    }
    
    private func registerCustomFonts() {
        Font.customFonts.forEach { $0.register() }
    }
    
    private func configureRefreshControl() {
        UIRefreshControl.appearance().tintColor = AppResourceAsset.Color.lubbyBlue.color
    }
    
    private func registerKakaoSDK() {
        guard let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String else {
            fatalError("KAKAO_APP_KEY is nil")
        }
        KakaoSDK.initSDK(appKey: kakaoAppKey, loggingEnable: true)
    }
}
