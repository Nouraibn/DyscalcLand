import SpriteKit
import SwiftData

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
    var nextButton: SKSpriteNode! // New node for navigation button
    var nextLabel: SKLabelNode!
    var NumBalloon: SKSpriteNode!
    var EndLabel: SKLabelNode! // New node for navigation label
    
    // Flags to track progress
    var isBalloon1Popped = false
    var isBalloon2Popped = false

    // Track the order of taps
    var tapIndex = 0
    let soundSequence = ["A1.mp3", "A2.mp3"]
    
    override func didMove(to view: SKView) {
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        
        // Initialize nodes from the .sks file
        background = self.childNode(withName: "Background") as? SKSpriteNode
        num2Balloon = self.childNode(withName: "ABalloon2") as? SKSpriteNode
        balloon1 = self.childNode(withName: "Balloon1") as? SKSpriteNode
        balloon2 = self.childNode(withName: "Balloon2") as? SKSpriteNode
        border = self.childNode(withName: "Border") as? SKSpriteNode
        popBalloon1 = self.childNode(withName: "PopBalloon1") as? SKSpriteNode
        popBalloon2 = self.childNode(withName: "PopBalloon2") as? SKSpriteNode
        guidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
        equalLabel = self.childNode(withName: "Equal") as? SKLabelNode
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        nextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode
        EndLabel = self.childNode(withName: "EndLabel") as? SKLabelNode
        NumBalloon = self.childNode(withName: "Num2Balloon") as? SKSpriteNode
        
        // Set zPosition for background and border
        background?.zPosition = -1
        border?.zPosition = -1
        
        // Initial state: hide popBalloon1, popBalloon2, num2Balloon, nextButton, and nextLabel
        popBalloon1.isHidden = true
        popBalloon2.isHidden = true
        num2Balloon.isHidden = true
        nextButton?.isHidden = true
        nextLabel?.isHidden = true
        NumBalloon?.isHidden = true
        EndLabel?.isHidden = true
        
        addPulsingAnimation(to: nextButton)
        addPulsingAnimation(to: nextLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if let balloon = node as? SKSpriteNode {
                handleBalloonTapped(balloon: balloon)
            } else if node == nextButton || node == nextLabel {
                run(SKAction.playSoundFileNamed("Button.mp3", waitForCompletion: false))
                navigateToNumber3()
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
    
    func handleBalloonTapped(balloon: SKSpriteNode) {
        // Determine which pop balloon to show
        if balloon == balloon1, !isBalloon1Popped {
            popBalloon1.isHidden = false
            balloon1.isHidden = true
            isBalloon1Popped = true
        } else if balloon == balloon2, !isBalloon2Popped {
            popBalloon2.isHidden = false
            balloon2.isHidden = true
            isBalloon2Popped = true
        } else {
            return // Ignore if the balloon is already popped
        }
        
        // Play the next sound in the sequence
        if tapIndex < soundSequence.count {
            let sound = soundSequence[tapIndex]
            let Sound1 = SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false)
            let Sound2 = SKAction.playSoundFileNamed(sound, waitForCompletion: false)
            self.run(SKAction.sequence([Sound1, Sound2]))
            tapIndex += 1
        }
        
        // Check if all balloons are popped
        checkCompletion()
    }
    
    func checkCompletion() {
        // If both balloons are popped, show num2Balloon and navigation options
        if isBalloon1Popped && isBalloon2Popped {
            let delay = SKAction.wait(forDuration: 2.0)
            let revealAction = SKAction.run { [weak self] in
                self?.num2Balloon?.isHidden = false
                self?.EndLabel?.isHidden = false
            }
            let Sound3 = SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false)
            let Sound4 = SKAction.playSoundFileNamed("Ayes2.mp3", waitForCompletion: false)
            let PlaySound = SKAction.sequence([delay, revealAction, Sound3, Sound4])
            self.run(PlaySound)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.nextButton?.isHidden = false
                self?.nextLabel?.isHidden = false
                self?.nextButton?.zPosition = 1
                self?.nextLabel?.zPosition = 2
            }
        }
    }
    
    func navigateToNumber3() {
        GameProgress.shared.saveProgress(for: 1, subLevel: 2)
        
        // Navigate to the Number3 scene
        if let number3Scene = SKScene(fileNamed: "Number3") {
            number3Scene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(number3Scene, transition: transition)
        }
    }
}
