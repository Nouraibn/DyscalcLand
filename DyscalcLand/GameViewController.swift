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
        modelContext = modelContainer?.mainContext
        
        // Initialize levels if needed
        if let context = modelContext {
            initializeGameProgress(context: context)
        } else {
            print("Error: ModelContext is nil. Failed to initialize levels.")
        }
        
        // Load the initial scene
        if let view = self.view as? SKView {
            if let scene = WelcomeScreen(fileNamed: "WelcomeScreen") {
                // Pass the ModelContext to the first scene
                scene.scaleMode = .aspectFill
                
                // Present the scene
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
    
    // Function to initialize levels
    func initializeGameProgress(context: ModelContext) {
        let fetchRequest = FetchDescriptor<GameProgress>()
        
        if (try? context.fetch(fetchRequest).isEmpty) ?? true {
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
            try? context.save()
            
            func completeClass(levelID: Int, partID: Int, classID: Int) {
                let fetchRequest = FetchDescriptor<GameProgress>(predicate: #Predicate { $0.levelID == levelID && $0.partID == partID && $0.classID == classID })
                
                if let currentClass = try? modelContext?.fetch(fetchRequest).first {
                    currentClass.isCompleted = true
                    
                    // Unlock the next class
                    let nextClassRequest = FetchDescriptor<GameProgress>(
                        predicate: #Predicate { $0.levelID == levelID && $0.partID == partID && $0.classID == classID + 1 }
                    )
                    if let nextClass = try? modelContext?.fetch(nextClassRequest).first {
                        nextClass.isUnlocked = true
                    }
                    
                    // Check if part is complete
                    let partRequest = FetchDescriptor<GameProgress>(
                        predicate: #Predicate { $0.levelID == levelID && $0.partID == partID }
                    )
                    if let part = try? modelContext?.fetch(partRequest), part.allSatisfy({ $0.isCompleted }) {
                        unlockNextPart(levelID: levelID, partID: partID)
                    }
                    
                    try? modelContext?.save()
                }
            }

            func unlockNextPart(levelID: Int, partID: Int) {
                let nextPartRequest = FetchDescriptor<GameProgress>(
                    predicate: #Predicate { $0.levelID == levelID && $0.partID == partID + 1 && $0.classID == 1 }
                )
                if let nextPartFirstClass = try? modelContext?.fetch(nextPartRequest).first {
                    nextPartFirstClass.isUnlocked = true
                }
                
                // If all parts are complete, unlock the next level
                let levelRequest = FetchDescriptor<GameProgress>(
                    predicate: #Predicate { $0.levelID == levelID }
                )
                if let levelParts = try? modelContext!.fetch(levelRequest), levelParts.allSatisfy({ $0.isCompleted }) {
                    unlockNextLevel(levelID: levelID)
                }
            }

            func unlockNextLevel(levelID: Int) {
                let nextLevelRequest = FetchDescriptor<GameProgress>(
                    predicate: #Predicate { $0.levelID == levelID + 1 && $0.partID == 1 && $0.classID == 1 }
                )
                if let nextLevelFirstClass = try? modelContext!.fetch(nextLevelRequest).first {
                    nextLevelFirstClass.isUnlocked = true
                }
                try? modelContext?.save()
            }

        }
    }

}
