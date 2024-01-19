import Combine

class LockedViewModel : ObservableObject {
    @Published var attempt : [Int] = []
    
    // Dependencies
    private let lockManager : LockManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(lockManager: LockManager) {
        self.lockManager = lockManager
        addSubscriptions()
    }
    
    private func addSubscriptions() {
        subscribeToAttempt()
    }
}

// MARK: - Subscriptions
private extension LockedViewModel {
    func subscribeToAttempt() {
        self.$attempt
            .sink { [weak self] updatedAttempt in
                print(updatedAttempt)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Set number value
extension LockedViewModel {
    func setNumber(angle : Double) {
        guard attempt.count < 5 else { return }
        // Normalize the angle to be within 0 to 360
        let normalizedAngle = normalize(angle: -angle)
        
        // Calculate the dial value from the normalized angle
        let value = Int((normalizedAngle / 36.0).rounded()) % 10
        attempt.append(value)
    }
}

// MARK: - Normalize an angle
extension LockedViewModel {
    // This is to handle the case where the user spins the dial past 360 and -360
    func normalize(angle: Double) -> Double {
        let normalizedAngle = angle.truncatingRemainder(dividingBy: 360.0)
        return normalizedAngle >= 0 ? normalizedAngle : normalizedAngle + 360.0
    }
}
