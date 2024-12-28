import SpriteKit
import GameplayKit
import SwiftData

class WelcomeScreen: SKScene {
    
    var parentController: GameViewController?
    // Nodes (References to nodes from the .sks file)
    private var background: SKSpriteNode!
    private var welcomeBoard: SKSpriteNode!
    private var startButton: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
       

        // Retrieve nodes from the .sks file by their names
        background = self.childNode(withName: "Background") as? SKSpriteNode
        welcomeBoard = self.childNode(withName: "WelcomeBoard") as? SKSpriteNode
        startButton = self.childNode(withName: "Button") as? SKSpriteNode
        
        // Adjust zPosition for each node
        background?.zPosition = -1 // Place it behind everything
        welcomeBoard?.zPosition = 1 // Place it above the background
        startButton?.zPosition = 10 // Ensure button is in front
    }
    
    // Handle touch events to navigate when the Start Button is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            // Check if the Start Button is tapped
            if node.name == "Button" {
                goToNextScene()
            }
        }
    }
    
    // Function to navigate to the next scene
    func goToNextScene() {
        let nextScene = SKScene(fileNamed: "ClownMap") as? ClownMap

        nextScene?.scaleMode = .aspectFill
        let transition = SKTransition.fade(withDuration: 1.0) // Fade transition
        self.view?.presentScene(nextScene!, transition: transition)
    }
}
