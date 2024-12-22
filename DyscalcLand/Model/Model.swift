

import Foundation
import SwiftData

@Model
class LevelProgress {
    @Attribute(.unique) var levelID: Int // Level ID (1, 2, 3 for the balls)
    var isUnlocked: Bool // Is this level (ball) unlocked?
    var pagesCompleted: Int // Number of pages completed in this level
    
    init(levelID: Int, isUnlocked: Bool = false, pagesCompleted: Int = 0) {
        self.levelID = levelID
        self.isUnlocked = isUnlocked
        self.pagesCompleted = pagesCompleted
    }
}


