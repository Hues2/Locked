import Foundation

class LockedViewModel : ObservableObject {
    
    private let lockManager : LockManager
    
    init(lockManager: LockManager) {
        self.lockManager = lockManager
    }
}
