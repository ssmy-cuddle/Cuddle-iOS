import Combine
import SwiftUI

import AppResource
import DesignSystem
import UIComponent

import CommunityFeature
import HomeFeature
import ProfileFeature

import AuthenticationFeature

import ComposableArchitecture

public struct ContentView: View {
    
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    @ObservedObject private var tabBarVisibility = TabBarVisibility(isTabBarVisible: true)
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    private let store: StoreOf<Content>
    
    // MARK: Init
    
    public init(store: StoreOf<Content>) {
        self.store = store
    }
    
    private let homeNavigationView = HomeNavigationView(
        store: StoreOf<HomeNavigation>(
            initialState: HomeNavigation.State()
        ) {
            HomeNavigation()
        }
    )
    
    private let diaryView = Text("서비스 준비 중입니다.")
        .font(.pretendardBody14)
    
    private let communityNavigation = CommunityNavigationView(
        store: StoreOf<CommunityNavigation>(
            initialState: CommunityNavigation.State()
        ) {
            CommunityNavigation()
        }
    )
    
    private let donationView = DonnationView()
    
    private let profileNavigation = ProfileNavigationView(
        store: StoreOf<ProfileNavigation>(
            initialState: ProfileNavigation.State()
        ) {
            ProfileNavigation()
        }
    )
    
    public var body: some View {
        WithPerceptionTracking {
            GeometryReader { proxy in
                VStack(spacing: 0) {
                    contentView(for: store.contentType)
                        .frame(maxHeight: .infinity)
                    
                    if tabBarVisibility.isTabBarVisible {
                        VStack(spacing: .zero) {
                            dividerView
                            navigationView(tabs: store.navigationTabs)
                        }
                    }
                }
                .environmentObject(tabBarVisibility)
            }
        }
    }
}

extension ContentView {
    
    @ViewBuilder
    public func buildView(for navigationType: NavigationTabType) -> some View {
        switch navigationType {
        case .home: homeNavigationView
        case .diary: diaryView
        case .comumnity: communityNavigation
        case .donation: donationView
        case .profile: ProfileNavigationView(
            store: store.scope(state: \.profile, action: \.profile)
        )
        }
    }
    
    @ViewBuilder
    private func contentView(for contentType: NavigationTabType) -> some View {
        ZStack {
            buildView(for: contentType)
        }
    }
    
    @ViewBuilder 
    private var dividerView: some View {
        Rectangle()
            .frame(height: 0.3)
            .foregroundStyle(Color(red: 0.52, green: 0.52, blue: 0.52))
    }
    
    
    @ViewBuilder 
    private func navigationView(tabs: [NavigationTabType]) -> some View {
        HStack {
            ForEach(tabs, id: \.hashValue) { navigationTab in
                VStack {
                    navigationItemView(tab: navigationTab)
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background {
                    store.state.contentType == navigationTab ? Circle()
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 1, y: 1) : nil
                }
                .onTapGesture {
                    store.send(.view(.changeTab(navigationTab)))
                }
            }
        }
        .background(.white)
        .padding(.top, 3)
        .padding(.horizontal, 8)
    }
    
    @ViewBuilder 
    private func navigationItemView(tab: NavigationTabType) -> some View {
        VStack(spacing: 4) {
            tab.icon
                .renderingMode(.template)
                .frame(width: 24, height: 24, alignment: .center)
                .foregroundColor(
                    store.state.contentType == tab ? tab.tintColor : Color(red: 0.52, green: 0.52, blue: 0.52)
                )
            Text(tab.title)
                .font(.npsTitle10)
                .foregroundStyle(
                    store.state.contentType == tab ? tab.tintColor : Color(red: 0.52, green: 0.52, blue: 0.52)
                )
        }
    }
}
