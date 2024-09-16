import SwiftUI

import AppResource
import DesignSystem

import ComposableArchitecture

@main
struct CuddleApp: App {
    
    let contentView: ContentView?
    
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
        WindowGroup { contentView }
    }
    
    private func registerCustomFonts() {
        Font.customFonts.forEach { $0.register() }
    }
    
    private func configureRefreshControl() {
        UIRefreshControl.appearance().tintColor = AppResourceAsset.Color.lubbyBlue.color
    }
}
