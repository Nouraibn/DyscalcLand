import SpriteKit
import SwiftData

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
    var nextButton: SKSpriteNode!
    var nextLabel: SKLabelNode!
    var NumBalloon: SKSpriteNode!
    var EndLabel: SKLabelNode! // New navigation label
    
    // Flags to track progress
    var isBalloon1Popped = false
    var isBalloon2Popped = false
    var isBalloon3Popped = false
    var isBalloon4Popped = false

    // Track the order of taps
    var tapIndex = 0
    let soundSequence = ["A1.mp3", "A2.mp3", "A3.mp3", "A4.mp3"]
    
    override func didMove(to view: SKView) {
        // Set the background color
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0

        // Initialize nodes
        background = self.childNode(withName: "Background") as? SKSpriteNode
        num4Balloon = self.childNode(withName: "ABalloon4") as? SKSpriteNode
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
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        nextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode
        EndLabel = self.childNode(withName: "EndLabel") as? SKLabelNode
        NumBalloon = self.childNode(withName: "Num4Balloon") as? SKSpriteNode

        background?.zPosition = -1
        border?.zPosition = -1

        // Initial state: hide unnecessary elements
        popBalloon1?.isHidden = true
        popBalloon2?.isHidden = true
        popBalloon3?.isHidden = true
        popBalloon4?.isHidden = true
        num4Balloon?.isHidden = true
        nextButton?.isHidden = true
        nextLabel?.isHidden = true
        EndLabel?.isHidden = true
        NumBalloon?.isHidden = true

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
                navigateToNumber5()
            }
        }
    }
    
    func addPulsingAnimation(to node: SKNode) {
        node.setScale(1.0)
        let scaleDown = SKAction.scale(to: 0.8, duration: 0.6)
        let scaleUp = SKAction.scale(to: 1.0, duration: 0.6)
        let pulse = SKAction.sequence([scaleDown, scaleUp])
        let repeatPulse = SKAction.repeatForever(pulse)
        node.run(repeatPulse)
    }
    
    func handleBalloonTapped(balloon: SKSpriteNode) {
        // Determine which pop balloon to show
        if balloon == balloon1, !isBalloon1Popped {
            popBalloon1?.isHidden = false
            balloon1?.isHidden = true
            isBalloon1Popped = true
        } else if balloon == balloon2, !isBalloon2Popped {
            popBalloon2?.isHidden = false
            balloon2?.isHidden = true
            isBalloon2Popped = true
        } else if balloon == balloon3, !isBalloon3Popped {
            popBalloon3?.isHidden = false
            balloon3?.isHidden = true
            isBalloon3Popped = true
        } else if balloon == balloon4, !isBalloon4Popped {
            popBalloon4?.isHidden = false
            balloon4?.isHidden = true
            isBalloon4Popped = true
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
        if isBalloon1Popped && isBalloon2Popped && isBalloon3Popped && isBalloon4Popped {
            let delay = SKAction.wait(forDuration: 2.0)
            let revealAction = SKAction.run { [weak self] in
                self?.num4Balloon?.isHidden = false
                self?.EndLabel?.isHidden = false
            }
            let Sound3 = SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false)
            let Sound4 = SKAction.playSoundFileNamed("Ayes4.mp3", waitForCompletion: false)
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
    
    func navigateToNumber5() {
        GameProgress.shared.saveProgress(for: 1, subLevel: 4)

        if let number5Scene = SKScene(fileNamed: "Number5") {
            number5Scene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(number5Scene, transition: transition)
        }
    }
}
