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
        modelContainer = try? ModelContainer(for: LevelProgress.self)
        modelContext = modelContainer?.mainContext
        
        // Initialize levels if needed
        if let context = modelContext {
            initializeLevels(context: context)
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
    func initializeLevels(context: ModelContext) {
        let fetchRequest = FetchDescriptor<LevelProgress>()
        if (try? context.fetch(fetchRequest).isEmpty) ?? true {
            let levels = [
                LevelProgress(levelID: 1, isUnlocked: true),  // Level 1 is unlocked by default
                LevelProgress(levelID: 2, isUnlocked: false),
                LevelProgress(levelID: 3, isUnlocked: false)
            ]
            for level in levels {
                context.insert(level)
            }
            try? context.save()
            print("Levels initialized successfully.")
        } else {
            print("Levels already initialized.")
        }
    }
}
