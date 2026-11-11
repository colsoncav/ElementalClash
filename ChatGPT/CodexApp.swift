import SwiftUI

@main
struct CodexApp: App {
    var body: some Scene {
        WindowGroup("Elemental Clash") {
            ContentView()
        }
        #if os(macOS)
        .defaultSize(width: 1500, height: 900)
        #endif
    }
}
