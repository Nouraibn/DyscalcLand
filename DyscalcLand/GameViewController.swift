import UIKit
import SpriteKit
import GameplayKit
import SwiftData

class GameViewController: UIViewController {

    
    var modelContainer: ModelContainer?
    var modelContext: ModelContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize ModelContainer and ModelContext
        do {
               modelContainer = try ModelContainer(for: GameProgress.self, LevelProgress.self)
               modelContext = modelContainer?.mainContext
           } catch {
               print("Failed to initialize ModelContainer: \(error.localizedDescription)")
           }
        
        // Initialize levels if needed
        if let context = modelContext {
            initializeGameProgress(context: context)
        } else {
            print("Error: ModelContext is nil. Failed to initialize levels.")
        }
        
        // Load the initial scene
        if let view = self.view as? SKView {
            if let scene = WelcomeScreen(fileNamed: "WelcomeScreen") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            } else {
                print("Error: Could not load WelcomeScreen.sks")
            }

            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func initializeGameProgress(context: ModelContext) {
        let fetchRequest = FetchDescriptor<GameProgress>()
        
        do {
            let existingProgress = try context.fetch(fetchRequest)
            if existingProgress.isEmpty {
                print("Initializing game progress...")
                let levels = [
                    (1, 2, 5), // Numeric: 2 parts, 5 classes each
                    (2, 5, 2), // Addition: 5 parts, 2 classes each
                    (3, 5, 3)  // Subtraction: 5 parts, 3 classes each
                ]
                
                for (levelID, partCount, classCount) in levels {
                    for partID in 1...partCount {
                        for classID in 1...classCount {
                            let isUnlocked = levelID == 1 && partID == 1 && classID == 1
                            let progress = GameProgress(levelID: levelID, partID: partID, classID: classID, isUnlocked: isUnlocked, isCompleted: false)
                            context.insert(progress)
                        }
                    }
                }
                try context.save()
                print("Game progress initialized.")
            } else {
                print("Game progress already exists.")
            }
        } catch {
            print("Failed to fetch or initialize game progress: \(error.localizedDescription)")
        }
    }

    func completeClass(levelID: Int, partID: Int, classID: Int) {
        let fetchRequest = FetchDescriptor<GameProgress>(
            predicate: #Predicate { $0.levelID == levelID && $0.partID == partID && $0.classID == classID }
        )
        
        do {
            guard let currentClass = try modelContext?.fetch(fetchRequest).first else {
                print("Class \(classID) not found in Part \(partID), Level \(levelID).")
                return
            }
            
            currentClass.isCompleted = true
            
            let nextClassRequest = FetchDescriptor<GameProgress>(
                predicate: #Predicate { $0.levelID == levelID && $0.partID == partID && $0.classID == classID + 1 }
            )
            if let nextClass = try modelContext?.fetch(nextClassRequest).first {
                nextClass.isUnlocked = true
                print("Next class unlocked: Level \(levelID), Part \(partID), Class \(classID + 1).")
            }
            
            let partRequest = FetchDescriptor<GameProgress>(
                predicate: #Predicate { $0.levelID == levelID && $0.partID == partID }
            )
            if let part = try modelContext?.fetch(partRequest),
               part.allSatisfy({ $0.isCompleted }) {
                unlockNextPart(levelID: levelID, partID: partID)
            }
            
            try modelContext?.save()
        } catch {
            print("Error completing class: \(error.localizedDescription)")
        }
    }

    func unlockNextPart(levelID: Int, partID: Int) {
        let nextPartRequest = FetchDescriptor<GameProgress>(
            predicate: #Predicate { $0.levelID == levelID && $0.partID == partID + 1 && $0.classID == 1 }
        )
        do {
            if let nextPartFirstClass = try modelContext?.fetch(nextPartRequest).first {
                nextPartFirstClass.isUnlocked = true
                try modelContext?.save()
                print("Next part unlocked: Part \(partID + 1) in Level \(levelID).")
            }
        } catch {
            print("Error unlocking next part: \(error.localizedDescription)")
        }
    }

    func unlockNextLevel(levelID: Int) {
        let nextLevelRequest = FetchDescriptor<GameProgress>(
            predicate: #Predicate { $0.levelID == levelID + 1 && $0.partID == 1 && $0.classID == 1 }
        )
        do {
            if let nextLevelFirstClass = try modelContext?.fetch(nextLevelRequest).first {
                nextLevelFirstClass.isUnlocked = true
                try modelContext?.save()
                print("Next level unlocked: Level \(levelID + 1).")
            }
        } catch {
            print("Error unlocking next level: \(error.localizedDescription)")
        }
    }
}
