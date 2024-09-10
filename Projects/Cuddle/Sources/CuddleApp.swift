import SwiftUI

import AppResource
import DesignSystem

import ComposableArchitecture

@main
struct CuddleApp: App {
    
    let contentView: ContentView?
    
    init() {
//        self.contentView = AppContainer.shared.resolve(ContentView.self)
        self.contentView = ContentView(
            store: StoreOf<Content>(
                initialState: Content.State()
            ) {
                Content()
            }
        )
        registerCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup { contentView }
    }
    
    private func registerCustomFonts() {
        Font.customFonts.forEach { $0.register() }
    }
}
