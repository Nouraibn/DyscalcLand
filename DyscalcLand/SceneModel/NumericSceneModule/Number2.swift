import SpriteKit

class Number2: SKScene {
    
    // Nodes from the .sks file
    var background: SKSpriteNode!
    var num2Balloon: SKSpriteNode!
    var balloon1: SKSpriteNode!
    var balloon2: SKSpriteNode!
    var border: SKSpriteNode!
    var popBalloon1: SKSpriteNode!
    var popBalloon2: SKSpriteNode!
    var guidingLabel: SKLabelNode!
    var equalLabel: SKLabelNode!
    
    // Flags to track progress
    var isBalloon1Popped = false
    var isBalloon2Popped = false
    
    override func didMove(to view: SKView) {
        
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0

        // Initialize nodes from the .sks file
        background = self.childNode(withName: "Background") as? SKSpriteNode
        num2Balloon = self.childNode(withName: "Num2Balloon") as? SKSpriteNode
        balloon1 = self.childNode(withName: "Balloon1") as? SKSpriteNode
        balloon2 = self.childNode(withName: "Balloon2") as? SKSpriteNode
        border = self.childNode(withName: "Border") as? SKSpriteNode
        popBalloon1 = self.childNode(withName: "PopBalloon1") as? SKSpriteNode
        popBalloon2 = self.childNode(withName: "PopBalloon2") as? SKSpriteNode
        guidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
        equalLabel = self.childNode(withName: "Equal") as? SKLabelNode
        
        
        background?.zPosition = -1
        border?.zPosition = -1
        
        // Initial state: hide popBalloon1, popBalloon2, and num2Balloon
        popBalloon1.isHidden = true
        popBalloon2.isHidden = true
        num2Balloon.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node == balloon1 {
                handleBalloon1Tapped()
            } else if node == balloon2 {
                handleBalloon2Tapped()
            }
        }
    }
    
    func handleBalloon1Tapped() {
        // Hide balloon1 and show popBalloon1
        balloon1.isHidden = true
        popBalloon1.isHidden = false
        isBalloon1Popped = true
        
        // Check if both balloons are popped
        checkCompletion()
    }
    
    func handleBalloon2Tapped() {
        // Hide balloon2 and show popBalloon2
        balloon2.isHidden = true
        popBalloon2.isHidden = false
        isBalloon2Popped = true
        
        // Check if both balloons are popped
        checkCompletion()
    }
    
    func checkCompletion() {
        // If both balloons are popped, show num2Balloon
        if isBalloon1Popped && isBalloon2Popped {
            num2Balloon.isHidden = false
        }
    }
}
