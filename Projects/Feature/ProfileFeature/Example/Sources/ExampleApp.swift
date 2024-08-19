import Foundation
import SwiftUI

import AppResource
import ProfileFeature

import ComposableArchitecture

@main
struct ExampleApp: App {
    init() {
        AppResourceFontFamily.registerAllCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        ProfileView(
            store: StoreOf<Profile>(
                initialState: Profile.State()
            ) {
                Profile()
            }
        )
    }
}

#Preview {
    ContentView()
}
