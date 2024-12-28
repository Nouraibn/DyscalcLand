import SwiftData


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
            1: MainLevel(totalSubLevels: 10),
            2: MainLevel(totalSubLevels: 10),
            3: MainLevel(totalSubLevels: 4)
        ]
    }

    func getMainLevel(_ index: Int) -> MainLevel? {
        return mainLevels[index]
    }

    // Add saveProgress to update the current sub-level or complete a main level
    func saveProgress(for mainLevel: Int, subLevel: Int) {
        if let level = mainLevels[mainLevel] {
            level.currentSubLevel = subLevel
            print("Progress saved: Main Level \(mainLevel), Sub Level \(subLevel)")
        } else {
            print("Error: Main Level \(mainLevel) not found.")
        }
    }
}

