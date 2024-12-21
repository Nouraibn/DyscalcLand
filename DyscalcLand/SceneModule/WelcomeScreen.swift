import SpriteKit
import GameplayKit

class WelcomeScreen: SKScene {
    
    // Nodes (References to nodes from the .sks file)
    private var background: SKSpriteNode!
    private var welcomeBoard: SKSpriteNode!
    private var startButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        // 1. Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0


        // 2. Retrieve nodes from the .sks file by their names
        background = self.childNode(withName: "Background") as? SKSpriteNode
        welcomeBoard = self.childNode(withName: "WelcomeBoard") as? SKSpriteNode
        startButton = self.childNode(withName: "Button") as? SKSpriteNode
        
        // 3. Verify nodes exist and adjust their zPosition
        if let background = background {
            background.zPosition = -1 // Place it behind everything
        } else {
            print("Error: 'Background' node not found in GameScene.sks")
        }
        
        if let welcomeBoard = welcomeBoard {
            welcomeBoard.zPosition = 1
        } else {
            print("Error: 'WelcomeBoard' node not found in GameScene.sks")
        }
        
        if let startButton = startButton {
            startButton.zPosition = 10 // Ensure button is in front
            startButton.name = "Button" // Ensure the name is set programmatically
        } else {
            print("Error: 'Button' node not found in GameScene.sks")
        }
    }
    
    // Handle touch events to navigate when the Start Button is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            // Debug: Print the name of the touched node
            print("Touched Node Name: \(node.name ?? "No Name")")
            print("All nodes at location: \(self.nodes(at: location).map { $0.name ?? "No Name" })")

            // Check if the Start Button is tapped
            if node.name == "Button" {
                print("Start Button Pressed!")
                goToNextScene()
            } else {
                print("Node name does not match 'Button'.")
            }
        }
    }
    
    // Function to navigate to the next scene
    func goToNextScene() {
        if let nextScene = SKScene(fileNamed: "ClownMap") {
            nextScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1.0) // Fade transition
            self.view?.presentScene(nextScene, transition: transition)
        } else {
            print("Error: 'MainGameScene.sks' not found!")
        }
    }
}
