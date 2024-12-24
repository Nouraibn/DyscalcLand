import SwiftData

@Model
class GameProgress {
    @Attribute(.unique) var levelID: Int // Numeric: 1, Addition: 2, Subtraction: 3
    @Attribute(.unique) var partID: Int // Part within a level (1-based index)
    @Attribute(.unique) var classID: Int // Class within a part (1-based index)
    var isUnlocked: Bool // Is this class unlocked?
    var isCompleted: Bool // Is this class completed?
    
    init(levelID: Int, partID: Int, classID: Int, isUnlocked: Bool, isCompleted: Bool) {
        self.levelID = levelID
        self.partID = partID
        self.classID = classID
        self.isUnlocked = isUnlocked
        self.isCompleted = isCompleted
    }
}
