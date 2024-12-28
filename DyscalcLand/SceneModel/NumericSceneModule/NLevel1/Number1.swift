import SpriteKit
import SwiftData

class Number1: SKScene {
    
  

  
    // Nodes for fixed assets
    var Background: SKSpriteNode!
    var Border: SKSpriteNode!
    var Balloon: SKSpriteNode!
    var Num1Balloon: SKSpriteNode!
    var PopBalloon: SKSpriteNode!
    var EqualLabel: SKSpriteNode!
    var GuidingLabel: SKSpriteNode!
    var NextButton: SKSpriteNode! // New node for navigation button
    var NextLabel: SKLabelNode! // New node for navigation label
    

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
        NextButton = self.childNode(withName: "NextButton") as? SKSpriteNode // Load the new button node
        NextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode // Load the new label node
        
        // Ensure Background and Border are not nil and set positions
        Background?.zPosition = -2
        Border?.zPosition = -1
        
        // Set the initial state for other nodes
        PopBalloon?.isHidden = true
        Num1Balloon?.isHidden = true
        Balloon?.isHidden = false
        EqualLabel?.isHidden = false
        GuidingLabel?.isHidden = false
        NextButton?.isHidden = true // Initially hide the NextButton
        NextLabel?.isHidden = true // Initially hide the NextLabel
        
        print("Scene initialized successfully.")
        run(SKAction.playSoundFileNamed("guess.wav", waitForCompletion: false))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let node = self.atPoint(touchLocation)
            
            // Check if the balloon is tapped
            if node == Balloon {
                BalloonTapped()
            }
           
            // Check if the NextButton or NextLabel is tapped
            if node == NextButton || node == NextLabel {
                navigateToNumber2()
            }
        }
    }
    
    func BalloonTapped() {
        // When the balloon is tapped:
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))

        // 1. Hide the balloon
        // 2. Show the pop balloon and number balloon
        Balloon?.isHidden = true
        PopBalloon?.isHidden = false
        run(SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false))

        Num1Balloon?.isHidden = false
        
        // Show the NextButton and NextLabel after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.NextButton?.isHidden = false
            self?.NextLabel?.isHidden = false
            self?.NextButton?.zPosition = 1
            self?.NextLabel?.zPosition = 2
        }
    }
    
    
    func navigateToNumber2() {
        
        GameProgress.shared.saveProgress(for: 1, subLevel: 1)
         // Navigate to the Number2 scene
         if let number2Scene = SKScene(fileNamed: "Number2") {
             number2Scene.scaleMode = .aspectFill
             let transition = SKTransition.fade(withDuration: 1.0)
             self.view?.presentScene(number2Scene, transition: transition)
         }
     }
}
