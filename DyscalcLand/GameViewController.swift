import UIKit
import SpriteKit
import GameplayKit
import SwiftData

class GameViewController: UIViewController {
    
    private var dataContainer: ModelContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
   
    private func setupDataContainer() {
        do {
            dataContainer = try ModelContainer(for: MainLevel.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
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
