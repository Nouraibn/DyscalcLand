import SpriteKit
import SwiftData

class Number7: SKScene {
    
    // Nodes from the .sks file
    var background: SKSpriteNode!
    var num7Balloon: SKSpriteNode!
    var balloon1: SKSpriteNode!
    var balloon2: SKSpriteNode!
    var balloon3: SKSpriteNode!
    var balloon4: SKSpriteNode!
    var balloon5: SKSpriteNode!
    var balloon6: SKSpriteNode!
    var balloon7: SKSpriteNode!
    var border: SKSpriteNode!
    var popBalloon1: SKSpriteNode!
    var popBalloon2: SKSpriteNode!
    var popBalloon3: SKSpriteNode!
    var popBalloon4: SKSpriteNode!
    var popBalloon5: SKSpriteNode!
    var popBalloon6: SKSpriteNode!
    var popBalloon7: SKSpriteNode!
    var guidingLabel: SKLabelNode!
    var equalLabel: SKLabelNode!
    var nextButton: SKSpriteNode!
    var nextLabel: SKLabelNode!
    
    // Flags to track progress
    var isBalloon1Popped = false
    var isBalloon2Popped = false
    var isBalloon3Popped = false
    var isBalloon4Popped = false
    var isBalloon5Popped = false
    var isBalloon6Popped = false
    var isBalloon7Popped = false
    
    var modelContext: ModelContext! // Reference to SwiftData model context
    
    override func didMove(to view: SKView) {
        
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0

        // Initialize nodes from the .sks file
        background = self.childNode(withName: "Background") as? SKSpriteNode
        num7Balloon = self.childNode(withName: "Num7Balloon") as? SKSpriteNode
        balloon1 = self.childNode(withName: "Balloon1") as? SKSpriteNode
        balloon2 = self.childNode(withName: "Balloon2") as? SKSpriteNode
        balloon3 = self.childNode(withName: "Balloon3") as? SKSpriteNode
        balloon4 = self.childNode(withName: "Balloon4") as? SKSpriteNode
        balloon5 = self.childNode(withName: "Balloon5") as? SKSpriteNode
        balloon6 = self.childNode(withName: "Balloon6") as? SKSpriteNode
        balloon7 = self.childNode(withName: "Balloon7") as? SKSpriteNode
        border = self.childNode(withName: "Border") as? SKSpriteNode
        popBalloon1 = self.childNode(withName: "PopBalloon1") as? SKSpriteNode
        popBalloon2 = self.childNode(withName: "PopBalloon2") as? SKSpriteNode
        popBalloon3 = self.childNode(withName: "PopBalloon3") as? SKSpriteNode
        popBalloon4 = self.childNode(withName: "PopBalloon4") as? SKSpriteNode
        popBalloon5 = self.childNode(withName: "PopBalloon5") as? SKSpriteNode
        popBalloon6 = self.childNode(withName: "PopBalloon6") as? SKSpriteNode
        popBalloon7 = self.childNode(withName: "PopBalloon7") as? SKSpriteNode
        guidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
        equalLabel = self.childNode(withName: "Equal") as? SKLabelNode
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        nextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode
        
        background?.zPosition = -1
        border?.zPosition = -1
        
        // Initial state: hide all popBalloon nodes, num7Balloon, nextButton, and nextLabel
        popBalloon1.isHidden = true
        popBalloon2.isHidden = true
        popBalloon3.isHidden = true
        popBalloon4.isHidden = true
        popBalloon5.isHidden = true
        popBalloon6.isHidden = true
        popBalloon7.isHidden = true
        num7Balloon.isHidden = true
        nextButton?.isHidden = true
        nextLabel?.isHidden = true
        
        addPulsingAnimation(to: nextButton)
        addPulsingAnimation(to: nextLabel)
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
            } else if node == balloon5 {
                handleBalloon5Tapped()
            } else if node == balloon6 {
                handleBalloon6Tapped()
            } else if node == balloon7 {
                handleBalloon7Tapped()
            } else if node == nextButton || node == nextLabel {
                run(SKAction.playSoundFileNamed("Button.mp3", waitForCompletion: false))
                navigateToNumber8()
            }
        }
    }
    func addPulsingAnimation(to node: SKNode) {
        node.setScale(1.0) // Ensure the node starts at its original size
        let scaleDown = SKAction.scale(to: 0.8, duration: 0.6) // Scale down to 80% of the original size
        let scaleUp = SKAction.scale(to: 1.0, duration: 0.6) // Scale back to the original size
        let pulse = SKAction.sequence([scaleDown, scaleUp]) // Create a sequence of actions
        let repeatPulse = SKAction.repeatForever(pulse) // Repeat the pulsing forever
        node.run(repeatPulse) // Apply the animation to the node
    }
    
    func handleBalloon1Tapped() {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon1.isHidden = true
        popBalloon1.isHidden = false
        isBalloon1Popped = true
        checkCompletion()
    }
    
    func handleBalloon2Tapped() {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon2.isHidden = true
        popBalloon2.isHidden = false
        isBalloon2Popped = true
        checkCompletion()
    }
    
    func handleBalloon3Tapped() {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon3.isHidden = true
        popBalloon3.isHidden = false
        isBalloon3Popped = true
        checkCompletion()
    }
    
    func handleBalloon4Tapped() {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon4.isHidden = true
        popBalloon4.isHidden = false
        isBalloon4Popped = true
        checkCompletion()
    }
    
    func handleBalloon5Tapped() {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon5.isHidden = true
        popBalloon5.isHidden = false
        isBalloon5Popped = true
        checkCompletion()
    }
    
    func handleBalloon6Tapped() {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon6.isHidden = true
        popBalloon6.isHidden = false
        isBalloon6Popped = true
        checkCompletion()
    }
    
    func handleBalloon7Tapped() {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon7.isHidden = true
        popBalloon7.isHidden = false
        isBalloon7Popped = true
        checkCompletion()
    }
    
    func checkCompletion() {
        if isBalloon1Popped && isBalloon2Popped && isBalloon3Popped && isBalloon4Popped && isBalloon5Popped && isBalloon6Popped && isBalloon7Popped {
            run(SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false))
            num7Balloon.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.nextButton?.isHidden = false
                self?.nextLabel?.isHidden = false
                self?.nextButton?.zPosition = 1
                self?.nextLabel?.zPosition = 2
            }
        }
    }
    
    func navigateToNumber8() {
        
        GameProgress.shared.saveProgress(for: 1, subLevel: 7)

         // Navigate to the Number4 scene
         if let number8Scene = SKScene(fileNamed: "Number8") {
             number8Scene.scaleMode = .aspectFill
             let transition = SKTransition.fade(withDuration: 1.0)
             self.view?.presentScene(number8Scene, transition: transition)
         }
     }
}
