import UIKit
import SpriteKit
import GameplayKit
import SwiftData

class GameViewController: UIViewController {
    
    private var dataContainer: ModelContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // إنشاء الحاوية وتسجيل النماذج
        setupDataContainer()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'WelcomeScreen.sks'
            if let scene = SKScene(fileNamed: "WelcomeScreen") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Pass reference to this controller for scene management
                if let welcomeScene = scene as? WelcomeScreen {
                    welcomeScene.parentController = self
                }
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    // إعداد الحاوية الخاصة بـ SwiftData
    private func setupDataContainer() {
        do {
            dataContainer = try ModelContainer(for: MainLevel.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    // الانتقال إلى مشهد الخريطة
    func moveToMapScene() {
        if let view = self.view as? SKView {
            if let ClownMap = SKScene(fileNamed: "ClownMap") as? ClownMap {
                ClownMap.parentController = self
                ClownMap.scaleMode = .aspectFill
                let transition = SKTransition.fade(withDuration: 1.0)
                view.presentScene(ClownMap, transition: transition)
            }
        }
    }

    // الانتقال إلى المرحلة الفرعية
    func moveToSubLevelScene(mainLevel: Int, subLevel: Int) {
        if let view = self.view as? SKView {
            // Define mappings for each main level and its sub-levels
            let subLevelMappings: [Int: [String]] = [
                1: (1...10).map { "Number\($0)" }, // Main Level 1: Number1 to Number10
                2: [
                    "DragAndDrop1", "Equation1", "DragAndDrop2", "Equation2",
                    "DragAndDrop3", "Equation3", "DragAndDrop4", "Equation4",
                    "DragAndDrop5", "Equation5"
                ], // Main Level 2
                3: ["Sub1", "Sub2", "Sub3", "Sub4"] // Main Level 3
            ]

            // Retrieve the mapping for the given main level
            if let subLevelNames = subLevelMappings[mainLevel], subLevel > 0, subLevel <= subLevelNames.count {
                let sceneName = subLevelNames[subLevel - 1] // Sub-levels are 1-indexed

                // Load the scene by its name
                if let subLevelScene = SKScene(fileNamed: sceneName) {
                    subLevelScene.scaleMode = .aspectFill // Ensure the scale mode is set
                    
                    // Pass data to the scene using userData
                    subLevelScene.userData = [
                        "mainLevel": mainLevel,
                        "subLevel": subLevel
                    ] as NSMutableDictionary

                    // Present the scene with a transition
                    let transition = SKTransition.crossFade(withDuration: 1.0)
                    view.presentScene(subLevelScene, transition: transition)
                } else {
                    print("Error: Scene \(sceneName) not found.")
                }
            } else {
                print("Error: Invalid sub-level \(subLevel) for main level \(mainLevel).")
            }
        }
    }

    // إضافة بيانات جديدة إلى الحاوية
    func addMainLevel(totalSubLevels: Int) {
        do {
            let context = dataContainer.mainContext
            let newLevel = MainLevel(totalSubLevels: totalSubLevels)
            context.insert(newLevel)
            try context.save()
            print("MainLevel added successfully!")
        } catch {
            print("Failed to save MainLevel: \(error)")
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
}
