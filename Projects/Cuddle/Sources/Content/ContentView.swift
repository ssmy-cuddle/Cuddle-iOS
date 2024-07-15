import SwiftUI

import AppResource
import DesignSystem

import AuthenticationFeature

import ComposableArchitecture

public struct ContentView: View {
    
    let store: StoreOf<Content>
    
    // MARK: Constants
    
    private enum Metric {
        static let splashDismissAnimationTimeInterval = 0.1
    }
    
    // MARK: Init
    
    public init(store: StoreOf<Content>) {
        self.store = store
    }
    
    // MARK: View Property
    
    private let splashScreenTransition: AnyTransition = .opacity.animation(
        .easeInOut(duration: Metric.splashDismissAnimationTimeInterval)
    )
    
    // MARK: Body
    
    public var body: some View {
        switch store.contentType {
        case .splash:
            SplashView()
                .transition(splashScreenTransition)
                .onAppear { onAppearSplashScreen() }
        case .main:
            Text("Main Screen")
                .font(.npsHeader20)
        case .login:
            AuthenticationNavigationView(
                store: StoreOf<AuthenticationCoordinator>(initialState: AuthenticationCoordinator.State()) {
                    AuthenticationCoordinator()
                }
            )
        }
    }
    
    // MARK: Private Method
    
    private func onAppearSplashScreen() {
        store.send(.view(.splashStarted))
    }
}

struct ContentView_Previews: PreviewProvider {
    
    let store: StoreOf<Content>
    
    init(store: StoreOf<Content>) {
        self.store = store
    }
    
    static var previews: some View {
        ContentView(
            store: StoreOf<Content>(initialState: Content.State()) {
                Content()
            }
        )
    }
}
