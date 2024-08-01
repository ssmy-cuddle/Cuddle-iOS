import Foundation
import SwiftUI

import CommunityFeature
import AppResource

@main
struct ExampleApp: App {
    init() {
        AppResourceFontFamily.registerAllCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            CommunityView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("Community Feature Example App")
            .padding()
    }
}

#Preview {
    ContentView()
}
