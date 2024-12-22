import SpriteKit

class Number1: SKScene {
    
    // Nodes for fixed assets
    var Background: SKSpriteNode!
    var Border: SKSpriteNode!
    var Balloon: SKSpriteNode!
    var Num1Balloon: SKSpriteNode!
    var PopBalloon: SKSpriteNode!
    var EqualLabel: SKSpriteNode!
    var GuidingLabel: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        
        // Load fixed nodes from the scene
        Background = self.childNode(withName: "Background2") as? SKSpriteNode
        Border = self.childNode(withName: "Border2") as? SKSpriteNode
        Balloon = self.childNode(withName: "Balloon") as? SKSpriteNode
        Num1Balloon = self.childNode(withName: "Num1Balloon") as? SKSpriteNode
        PopBalloon = self.childNode(withName: "PopBalloon") as? SKSpriteNode
        EqualLabel = self.childNode(withName: "Equal") as? SKSpriteNode
        GuidingLabel = self.childNode(withName: "GuidingLabel") as? SKSpriteNode
        
        // Ensure Background and Border are not nil and set positions
        if let background = Background {
            background.zPosition = -2 // Ensure it's behind everything
            background.isHidden = false
            print("Background loaded successfully at position: \(background.position)")
        } else {
            print("Error: 'Background2' node not found.")
        }
        
        if let border = Border {
            border.zPosition = -1 // Place above the background but behind other elements
            border.isHidden = false
            print("Border loaded successfully at position: \(border.position)")
        } else {
            print("Error: 'Border2' node not found.")
        }
        
        // Set the initial state for other nodes
        PopBalloon?.isHidden = true
        Num1Balloon?.isHidden = true
        Balloon?.isHidden = false
        EqualLabel?.isHidden = false
        GuidingLabel?.isHidden = false
        
        print("Scene initialized successfully.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let node = self.atPoint(touchLocation)
            
            // Check if the balloon is tapped
            if node == Balloon {
                BalloonTapped()
            }
            
            // Check if the pop balloon or number balloon is tapped
            if node == PopBalloon || node == Num1Balloon {
                ResetBalloons()
            }
        }
    }
    
    func BalloonTapped() {
        // When the balloon is tapped:
        // 1. Hide the balloon
        // 2. Show the pop balloon and number balloon
        Balloon?.isHidden = true
        PopBalloon?.isHidden = false
        Num1Balloon?.isHidden = false
    }
    
    func ResetBalloons() {
        // When the pop balloon or number balloon is tapped:
        // 1. Hide the pop balloon and number balloon
        // 2. Show the balloon
        Balloon?.isHidden = false
        PopBalloon?.isHidden = true
        Num1Balloon?.isHidden = true
    }
}
