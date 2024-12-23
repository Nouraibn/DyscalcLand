import SpriteKit

class Number4: SKScene {
    
    // Nodes from the .sks file
    var background: SKSpriteNode!
    var num4Balloon: SKSpriteNode!
    var balloon1: SKSpriteNode!
    var balloon2: SKSpriteNode!
    var balloon3: SKSpriteNode!
    var balloon4: SKSpriteNode!
    var border: SKSpriteNode!
    var popBalloon1: SKSpriteNode!
    var popBalloon2: SKSpriteNode!
    var popBalloon3: SKSpriteNode!
    var popBalloon4: SKSpriteNode!
    var guidingLabel: SKLabelNode!
    var equalLabel: SKLabelNode!
    var nextButton: SKSpriteNode! // New node for navigation button
    var nextLabel: SKLabelNode! // New node for navigation label
    
    // Flags to track progress
    var isBalloon1Popped = false
    var isBalloon2Popped = false
    var isBalloon3Popped = false
    var isBalloon4Popped = false
    
    override func didMove(to view: SKView) {
        
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0

        // Initialize nodes from the .sks file
        background = self.childNode(withName: "Background") as? SKSpriteNode
        num4Balloon = self.childNode(withName: "Num4Balloon") as? SKSpriteNode
        balloon1 = self.childNode(withName: "Balloon1") as? SKSpriteNode
        balloon2 = self.childNode(withName: "Balloon2") as? SKSpriteNode
        balloon3 = self.childNode(withName: "Balloon3") as? SKSpriteNode
        balloon4 = self.childNode(withName: "Balloon4") as? SKSpriteNode
        border = self.childNode(withName: "Border") as? SKSpriteNode
        popBalloon1 = self.childNode(withName: "PopBalloon1") as? SKSpriteNode
        popBalloon2 = self.childNode(withName: "PopBalloon2") as? SKSpriteNode
        popBalloon3 = self.childNode(withName: "PopBalloon3") as? SKSpriteNode
        popBalloon4 = self.childNode(withName: "PopBalloon4") as? SKSpriteNode
        guidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
        equalLabel = self.childNode(withName: "Equal") as? SKLabelNode
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode // Load the new button node
        nextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode // Load the new label node
        
        background?.zPosition = -1
        border?.zPosition = -1
        
        // Initial state: hide popBalloon1, popBalloon2, popBalloon3, popBalloon4, num4Balloon, nextButton, and nextLabel
        popBalloon1.isHidden = true
        popBalloon2.isHidden = true
        popBalloon3.isHidden = true
        popBalloon4.isHidden = true
        num4Balloon.isHidden = true
        nextButton?.isHidden = true
        nextLabel?.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node == balloon1 {
                handleBalloon1Tapped()
            } else if node == balloon2 {
                handleBalloon2Tapped()
            } else if node == balloon3 {
                handleBalloon3Tapped()
            } else if node == balloon4 {
                handleBalloon4Tapped()
            } else if node == nextButton || node == nextLabel {
                navigateToNumber5()
            }
        }
    }
    
    func handleBalloon1Tapped() {
        
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))

        // Hide balloon1 and show popBalloon1
        balloon1.isHidden = true
        popBalloon1.isHidden = false
        isBalloon1Popped = true
        
        // Check if all balloons are popped
        checkCompletion()
    }
    
    func handleBalloon2Tapped() {
        
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))

        // Hide balloon2 and show popBalloon2
        balloon2.isHidden = true
        popBalloon2.isHidden = false
        isBalloon2Popped = true
        
        // Check if all balloons are popped
        checkCompletion()
    }
    
    func handleBalloon3Tapped() {
        
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))

        // Hide balloon3 and show popBalloon3
        balloon3.isHidden = true
        popBalloon3.isHidden = false
        isBalloon3Popped = true
        
        // Check if all balloons are popped
        checkCompletion()
    }
    
    func handleBalloon4Tapped() {
        
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))

        // Hide balloon4 and show popBalloon4
        balloon4.isHidden = true
        popBalloon4.isHidden = false
        isBalloon4Popped = true
        
        // Check if all balloons are popped
        checkCompletion()
    }
    
    func checkCompletion() {
        
        
        // If all balloons are popped, show num4Balloon and navigation options
        if isBalloon1Popped && isBalloon2Popped && isBalloon3Popped && isBalloon4Popped {
            run(SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false))
            num4Balloon.isHidden = false
            
            // Show the NextButton and NextLabel after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.nextButton?.isHidden = false
                self?.nextLabel?.isHidden = false
                self?.nextButton?.zPosition = 1
                self?.nextLabel?.zPosition = 2
            }
        }
    }
    
    func navigateToNumber5() {
        // Navigate to the Number5 scene
        if let number5Scene = SKScene(fileNamed: "Number5") {
            number5Scene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(number5Scene, transition: transition)
        }
    }
}
