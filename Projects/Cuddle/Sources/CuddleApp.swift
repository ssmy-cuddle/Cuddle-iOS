import SwiftUI

import AppResource
import DesignSystem

@main
struct CuddleApp: App {
    
    init() {
        registerCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func registerCustomFonts() {
        Font.customFonts.forEach { $0.register() }
    }
}
