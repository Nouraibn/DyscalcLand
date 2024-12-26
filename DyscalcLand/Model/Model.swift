import SwiftData

@Model
class GameProgress {
    @Attribute(.unique) var levelID: Int
    @Attribute(.unique) var partID: Int
    @Attribute(.unique) var classID: Int
    var isUnlocked: Bool
    var isCompleted: Bool
    
    init(levelID: Int, partID: Int, classID: Int, isUnlocked: Bool, isCompleted: Bool) {
        self.levelID = levelID
        self.partID = partID
        self.classID = classID
        self.isUnlocked = isUnlocked
        self.isCompleted = isCompleted
    }
}

@Model
class LevelProgress {
    @Attribute var level: Int
    @Attribute var isComplete: Bool
    
    init(level: Int, isComplete: Bool) {
        self.level = level
        self.isComplete = isComplete
    }
}
