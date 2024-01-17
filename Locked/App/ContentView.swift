import SwiftUI

struct ContentView: View {
    private let lockManager : LockManager
    
    init(lockManager: LockManager) {
        self.lockManager = lockManager
    }
    
    var body: some View {
        LockedView(lockManager: lockManager)
    }
}
