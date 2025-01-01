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
    var Click: SKSpriteNode!
    

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
        NextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        Click = self.childNode(withName: "Click") as? SKSpriteNode// Load the new button node
        NextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode // Load the new label node
        
        // Ensure Background and Border are not nil and set positions
        Background?.zPosition = -2
        Border?.zPosition = -1
        Click?.zPosition = 2
        
        // Set the initial state for other nodes
        PopBalloon?.isHidden = true
        Num1Balloon?.isHidden = true
        Balloon?.isHidden = false
        EqualLabel?.isHidden = false
        GuidingLabel?.isHidden = false
        NextButton?.isHidden = true // Initially hide the NextButton
        NextLabel?.isHidden = true // Initially hide the NextLabel
        
        addPulsingAnimation(to: NextButton)
        addPulsingAnimation(to: NextLabel)
        
        startOscillatingAnimation(for: Click, fromLeftOffset: 50, duration: 1.0)
         

        
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
                stopAndDisappear(for: Click)
            }
           
            // Check if the NextButton or NextLabel is tapped
            if node == NextButton || node == NextLabel {
                run(SKAction.playSoundFileNamed("Button.mp3", waitForCompletion: false))
                navigateToNumber2()
            }
        }
    }
    func startOscillatingAnimation(for node: SKNode?, fromLeftOffset offset: CGFloat, duration: TimeInterval = 3.0) {
            guard let node = node else { return }
            
            // Save the original position
            let originalPosition = node.position
            
            // Define actions
            let moveLeft = SKAction.moveBy(x: -offset, y: 0, duration: duration) // Move left in 3 seconds
            let moveRight = SKAction.move(to: originalPosition, duration: duration) // Return to original position in 3 seconds
        let pause = SKAction.wait(forDuration: 1.0) // Pause at the original position
        
        let scaleDown = SKAction.scale(to: 0.8, duration: 0.6) // Scale down to 80% of the original size
        let scaleUp = SKAction.scale(to: 1.0, duration: 0.6) // Scale back to the original size
        let pulse = SKAction.sequence([scaleDown, scaleUp])
                let oscillate = SKAction.sequence([pulse, moveLeft, moveRight, pause, pulse]) // Add pause to the sequence
                let repeatOscillation = SKAction.repeatForever(oscillate)

            // Run the oscillation
            node.run(repeatOscillation)
        }
        
        // Function to stop the animation and make the node disappear
        func stopAndDisappear(for node: SKNode?) {
            guard let node = node else { return }
            
            // Remove all actions
            node.removeAllActions()
            
            // Fade out and remove the node
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([fadeOut, remove])
            node.run(sequence)
        }
    
    func addPulsingAnimation(to node: SKNode) {
        node.setScale(1.0) // Ensure the node starts at its original size
        let scaleDown = SKAction.scale(to: 0.8, duration: 0.6) // Scale down to 80% of the original size
        let scaleUp = SKAction.scale(to: 1.0, duration: 0.6) // Scale back to the original size
        let pulse = SKAction.sequence([scaleDown, scaleUp]) // Create a sequence of actions
        let repeatPulse = SKAction.repeatForever(pulse) // Repeat the pulsing forever
        node.run(repeatPulse) // Apply the animation to the node
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
