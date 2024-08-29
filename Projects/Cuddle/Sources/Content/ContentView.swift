import Combine
import SwiftUI

import AppResource
import DesignSystem

import CommunityFeature
import HomeFeature
import ProfileFeature

import AuthenticationFeature

import ComposableArchitecture

public struct ContentView: View {
    
    @StateObject private var keyboardResponder = KeyboardResponder()
    
    let store: StoreOf<Content>
    
    private let homeView = HomeView()
    
    // MARK: Constants
    
    private enum Metric {
        static let splashDismissAnimationTimeInterval = 0.1
    }
    
    // MARK: Init
    
    public init(store: StoreOf<Content>) {
        self.store = store
        
//        let tabBarAppearance = UITabBarAppearance()
//        tabBarAppearance.configureWithTransparentBackground()
//        UITabBar.appearance().standardAppearance = tabBarAppearance
//        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    let communityNavigation = CommunityNavigationView(
        store: StoreOf<CommunityNavigation>(
            initialState: CommunityNavigation.State()
        ) {
            CommunityNavigation()
        }
    )
    
    let profileNavigation = ProfileNavigationView(
        store: StoreOf<ProfileNavigation>(
            initialState: ProfileNavigation.State()
        ) {
            ProfileNavigation()
        }
    )
    
    // MARK: View Property
    
    private let splashScreenTransition: AnyTransition = .opacity.animation(
        .easeInOut(duration: Metric.splashDismissAnimationTimeInterval)
    )
    
    // MARK: Body
    
    @ViewBuilder
    public func buildView(for navigationType: NavigationTabType) -> some View {
        switch navigationType {
        case .home: HomeView()
        case .diary: Text("서비스 준비 중입니다.")
                .font(.pretendardTitle14)
        case .comumnity: communityNavigation
        case .donation: Text("서비스 준비 중입니다.")
                .font(.pretendardTitle14)
        case .profile: ProfileNavigationView(
            store: StoreOf<ProfileNavigation>(
                initialState: ProfileNavigation.State()
            ) {
                ProfileNavigation()
            }
        )
        }
    }
//    
//    public lazy var tabView: some View  WithViewStore(store, observe: { $0 }) { store in
//        TabView(
//            selection: store.binding(get: \.contentType) {
//                Content.Action.view(.changeTab($0))
//            }
//        ) {
//            Group {
//                ForEach(store.navigationTabs, id: \.hashValue) {
//                    buildView(for: $0).tag($0)
//                }
//            }
//            .toolbar(.hidden, for: .tabBar)
//        }
//    }
    
    public var tabView: some View {
        WithViewStore(store, observe: { $0 }) { store in
            TabView(
                selection: store.binding(get: \.contentType) {
                    Content.Action.view(.changeTab($0))
                }
            ) {
                Group {
                    ForEach(store.navigationTabs, id: \.hashValue) {
                        buildView(for: $0).tag($0)
                    }
                }
                .toolbar(.hidden, for: .tabBar)
                .toolbarBackground(.hidden, for: .tabBar)
            }
        }
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
//            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    TabView(
                        selection: store.binding(get: \.contentType) {
                            Content.Action.view(.changeTab($0))
                        }
                    ) {
                        Group {
                            ForEach(store.navigationTabs, id: \.hashValue) {
                                buildView(for: $0).tag($0)
                            }
                        }
                        .toolbar(.hidden, for: .tabBar)
                        .toolbarBackground(.hidden, for: .tabBar)
                    }
                    .ignoresSafeArea(.all)
                    .tabViewStyle(.page(indexDisplayMode: .never))

                    Rectangle()
                        .frame(height: 0.3)
                        .foregroundStyle(Color(red: 0.52, green: 0.52, blue: 0.52))
                    
                    if !keyboardResponder.isKeyboardVisible {
                        HStack {
                            ForEach(store.navigationTabs, id: \.hashValue) { navigationTab in
                                VStack {
                                    VStack(spacing: 4) {
                                        navigationTab.icon
                                            .renderingMode(.template)
                                            .frame(width: 24, height: 24, alignment: .center)
                                            .foregroundColor(
                                                store.state.contentType == navigationTab ? navigationTab.tintColor : Color(red: 0.52, green: 0.52, blue: 0.52)
                                            )
                                        Text(navigationTab.title)
                                            .font(.npsTitle10)
                                            .foregroundStyle(
                                                store.state.contentType == navigationTab ? navigationTab.tintColor : Color(red: 0.52, green: 0.52, blue: 0.52)
                                            )
                                    }
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
                }
                .background(.white)
            }
//        }
            
//            
//            
//            
//            WithViewStore(store, observe: { $0 }) { store in
//                TabView(
//                    selection: store.binding(get: \.contentType) {
//                        Content.Action.view(.changeTab($0))
//                    }
//                ) {
//                    ForEach(store.state.navigationTabs, id: \.hashValue) { navigationTab in
//                        buildView(for: navigationTab)
//                            .tabItem {
//                                VStack {
//                                    navigationTab.icon
//                                        .renderingMode(.template)
//                                        .frame(width: 24, height: 24, alignment: .center)
//                                        .foregroundColor(
//                                            store.state.contentType == navigationTab ? navigationTab.tintColor : Color(red: 0.52, green: 0.52, blue: 0.52)
//                                        )
//                                    Text(navigationTab.title)
//                                        .font(.npsTitle12)
//                                        .foregroundStyle(
//                                            store.state.contentType == navigationTab ? navigationTab.tintColor : Color(red: 0.52, green: 0.52, blue: 0.52)
//                                        )
//                                }
//                                .aspectRatio(1, contentMode: .fit)
//                                .padding()
//                                .shadow(color: .black, radius: 8, x: 1, y: 1)
//                                .frame(width: 55, height: 55, alignment: .center)
//                                .background(.red)
//                                .background {
//                                    Circle()
//                                        .background(.white)
//                                        .frame(width: 55, height: 55, alignment: .center)
//                                        .shadow(color: .black, radius: 8, x: 1, y: 1)
//                                }
//                            }
//                            .tag(navigationTab)
//                            .onTapGesture {
//                                store.send(.view(.changeTab(navigationTab)))
//                            }
//                    }
//                }
//            }
//        }
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

class KeyboardResponder: ObservableObject {
    @Published var isKeyboardVisible: Bool = false
    
    private var willShowCancellable: AnyCancellable?
    private var willHideCancellable: AnyCancellable?
    
    init() {
        willShowCancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in true }
            .assign(to: \.isKeyboardVisible, on: self)
        
        willHideCancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }
            .assign(to: \.isKeyboardVisible, on: self)
    }
    
    deinit {
        willShowCancellable?.cancel()
        willHideCancellable?.cancel()
    }
}

//struct ContentView: View {
//    @StateObject private var keyboardResponder = KeyboardResponder()
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Enter something...", text: .constant(""))
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                Spacer()
//            }
//            .navigationTitle("My View")
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarHidden(keyboardResponder.isKeyboardVisible) // 키보드 상태에 따라 NavigationBar 숨김
//        }
//        .animation(.easeInOut(duration: 0.3)) // 부드러운 전환
//    }
//}
