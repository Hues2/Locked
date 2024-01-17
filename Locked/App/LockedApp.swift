import SwiftUI

@main
struct LockedApp: App {
    private let lockManager = LockManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(lockManager: lockManager)
        }
    }
}
