import Foundation
import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            DiaryViewExample()
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("Diary Feature Example App")
            .padding()
    }
}

#Preview {
    DiaryViewExample()
}
