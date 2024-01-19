import Foundation

class LockManager {
    @Published var answer : [Int] = []
    @Published var previousAttempts : [[Int]] = []
    
    init() {
        self.createNewAnswer()
    }
}

// MARK: - Create new answer
extension LockManager {
    func createNewAnswer() {
        let randomAnswer = (1...5).map { _ in Int.random(in: 0...9) }
        self.answer = randomAnswer
    }
}

// MARK: - Set up next attempt
extension LockManager {
    func setUpNextAttempt(attempt : [Int]) {
        guard self.previousAttempts.count < 3 else {
            // TODO: If number of attempts is already 3 then game over
            return
        }
        self.previousAttempts.append(attempt)
    }
}
