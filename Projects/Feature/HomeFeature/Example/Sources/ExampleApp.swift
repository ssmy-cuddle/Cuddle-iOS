import Foundation
import SwiftUI

import HomeFeature

@main
struct ExampleApp: App {
    init() {
        Font.customFonts.forEach { $0.register() }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

#Preview {
    ProfilePreviewContentView()
}
