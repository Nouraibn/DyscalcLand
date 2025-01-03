import SwiftData
import Foundation

@Model
class MainLevel {
    @Attribute(.unique) var id: UUID // معرف فريد لكل مرحلة رئيسية
    var currentSubLevel: Int // المرحلة الفرعية الحالية
    var totalSubLevels: Int // عدد المراحل الفرعية في المرحلة الرئيسية

    init(totalSubLevels: Int) {
        self.id = UUID()
        self.currentSubLevel = 1
        self.totalSubLevels = totalSubLevels
    }

    func completeCurrentSubLevel() -> Bool {
        if currentSubLevel < totalSubLevels {
            currentSubLevel += 1
            return false // لم تنته المرحلة الرئيسية بعد
        } else {
            return true // المرحلة الرئيسية مكتملة
        }
    }
}

class GameProgress {
    static let shared = GameProgress() // Singleton
    var mainLevels: [Int: MainLevel] = [:]

    private init() {
        mainLevels = [
            1: MainLevel(totalSubLevels: 10), // Main Level 1 has 10 sub-levels
            2: MainLevel(totalSubLevels: 10), // Main Level 2 has 10 sub-levels
            3: MainLevel(totalSubLevels: 8)  // Main Level 3 now has 8 sub-levels
        ]
    }

    func saveProgress(for mainLevel: Int, subLevel: Int) {
        if let level = mainLevels[mainLevel] {
            level.currentSubLevel = subLevel
            print("Progress saved: Main Level \(mainLevel), Sub Level \(subLevel)")
        } else {
            print("Error: Main Level \(mainLevel) not found.")
        }
    }

    func fetchProgress(for mainLevel: Int) -> (mainLevel: Int, subLevel: Int)? {
        if let level = mainLevels[mainLevel] {
            return (mainLevel, level.currentSubLevel)
        } else {
            print("Error: Main Level \(mainLevel) not found.")
            return nil
        }
    }
}

class EquationManager {
    var equationsByLevel: [Int: [Int: (equation: String, answer: Int)]] = [:]
    
    init() {
        self.setupEquations()
    }
    private func setupEquations() {
        equationsByLevel = [
            2: [
                2: ("1 + 1 = ", 2),
                4: ("2 + 2 = ", 4),
                6: ("4 + 2 = ", 6),
                8: ("3 + 2 = ", 5),
                10:("3 + 4 = ", 7)
            ]
        ]
    }
    func getEquation(for mainLevel: Int, subLevel: Int) -> (equation: String, answer: Int)? {
        if mainLevel == 2, let sublevels = equationsByLevel[mainLevel] {
            if let equation = sublevels[subLevel] {
                return equation
            } else {
                print("No equation found for \(mainLevel) \(subLevel)")
                return nil
                
            }
        }
        print("No equation found for \(mainLevel) \(subLevel)")
        return nil
    }
}



