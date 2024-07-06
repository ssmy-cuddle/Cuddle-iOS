import SwiftUI

import AppResource
import DesignSystem

import ComposableArchitecture

@main
struct CuddleApp: App {
    
    init() {
        registerCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: StoreOf<Content>(initialState: Content.State()) {
                Content()
            })
        }
    }
    
    private func registerCustomFonts() {
        Font.customFonts.forEach { $0.register() }
    }
}
