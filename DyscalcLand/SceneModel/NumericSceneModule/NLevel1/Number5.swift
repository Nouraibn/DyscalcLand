import SpriteKit
import SwiftData

class Number5: BaseScene {
    
    // Nodes from the .sks file
    var background: SKSpriteNode!
    var num5Balloon: SKSpriteNode!
    var balloon1: SKSpriteNode!
    var balloon2: SKSpriteNode!
    var balloon3: SKSpriteNode!
    var balloon4: SKSpriteNode!
    var balloon5: SKSpriteNode!
    var border: SKSpriteNode!
    var popBalloon1: SKSpriteNode!
    var popBalloon2: SKSpriteNode!
    var popBalloon3: SKSpriteNode!
    var popBalloon4: SKSpriteNode!
    var popBalloon5: SKSpriteNode!
    var guidingLabel: SKLabelNode!
    var equalLabel: SKLabelNode!
    var nextButton: SKSpriteNode!
    var nextLabel: SKLabelNode!
    var NumBalloon: SKSpriteNode! // New node for number balloon
    var EndLabel: SKLabelNode! // New node for the end label
    
    // Flags to track progress
    var isBalloon1Popped = false
    var isBalloon2Popped = false
    var isBalloon3Popped = false
    var isBalloon4Popped = false
    var isBalloon5Popped = false

    // Track the order of taps
    var tapIndex = 0
    let soundSequence = ["E1.mp4", "E2.mp4", "E3.mp4", "E4.mp4", "E5.mp4"]
    
    override func didMove(to view: SKView) {
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0

        // Initialize nodes from the .sks file
        background = self.childNode(withName: "Background") as? SKSpriteNode
        num5Balloon = self.childNode(withName: "ABalloon5") as? SKSpriteNode
        balloon1 = self.childNode(withName: "Balloon1") as? SKSpriteNode
        balloon2 = self.childNode(withName: "Balloon2") as? SKSpriteNode
        balloon3 = self.childNode(withName: "Balloon3") as? SKSpriteNode
        balloon4 = self.childNode(withName: "Balloon4") as? SKSpriteNode
        balloon5 = self.childNode(withName: "Balloon5") as? SKSpriteNode
        border = self.childNode(withName: "Border") as? SKSpriteNode
        popBalloon1 = self.childNode(withName: "PopBalloon1") as? SKSpriteNode
        popBalloon2 = self.childNode(withName: "PopBalloon2") as? SKSpriteNode
        popBalloon3 = self.childNode(withName: "PopBalloon3") as? SKSpriteNode
        popBalloon4 = self.childNode(withName: "PopBalloon4") as? SKSpriteNode
        popBalloon5 = self.childNode(withName: "PopBalloon5") as? SKSpriteNode
        guidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
        equalLabel = self.childNode(withName: "Equal") as? SKLabelNode
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        nextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode
        NumBalloon = self.childNode(withName: "Num5Balloon") as? SKSpriteNode
        EndLabel = self.childNode(withName: "EndLabel") as? SKLabelNode
        
        if let guidingLabel = guidingLabel {
            guidingLabel.fontName = "ComicSansMS-Bold"
            guidingLabel.text = "Pop the balloons and \n guess the number!"
            guidingLabel.fontSize = 28
            
            // Enable line breaks by setting the max width for the label
            guidingLabel.horizontalAlignmentMode = .center
            guidingLabel.verticalAlignmentMode = .center

            // Set the maximum width for the label (ensures line breaks occur)
            guidingLabel.preferredMaxLayoutWidth = 500 // Adjust based on your scene's layout

            // Set the number of lines to 0 for multiline support
            guidingLabel.numberOfLines = 0
        }

           if let nextLabel = nextLabel {
               nextLabel.fontName = "ComicSansMS-Bold"
               nextLabel.text = "Next"
               nextLabel.fontSize = 30
           }
           
        if let endLabel = EndLabel {
            let fullText = "Yes, it's number Five"
            
            // Create an attributed string
            let attributedString = NSMutableAttributedString(string: fullText)
            
            // Apply regular font to the entire string
            attributedString.addAttribute(.font, value: UIFont(name: "ComicSansMS", size: 32)!, range: NSRange(location: 0, length: fullText.count))
            
            // Define the range for the bold part (word "One")
            let boldRange = (fullText as NSString).range(of: "Five")
            
            // Apply the bold font to "One" (keep the font size the same for both parts)
            attributedString.addAttribute(.font, value: UIFont(name: "ComicSansMS-Bold", size: 34)!, range: boldRange)
            
            // Set the attributed string to the label
            endLabel.attributedText = attributedString
        }
        
        background?.zPosition = -1
        border?.zPosition = -1
        guidingLabel?.zPosition = 1

        
        // Initial state: hide unnecessary elements
        popBalloon1?.isHidden = true
        popBalloon2?.isHidden = true
        popBalloon3?.isHidden = true
        popBalloon4?.isHidden = true
        popBalloon5?.isHidden = true
        num5Balloon?.isHidden = true
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
                navigateToNumber6()
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
        } else if balloon == balloon5, !isBalloon5Popped {
            popBalloon5?.isHidden = false
            balloon5?.isHidden = true
            isBalloon5Popped = true
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
        if isBalloon1Popped && isBalloon2Popped && isBalloon3Popped && isBalloon4Popped && isBalloon5Popped {
            let delay = SKAction.wait(forDuration: 2.0)
            let revealAction = SKAction.run { [weak self] in
                self?.NumBalloon?.isHidden = false
                self?.EndLabel?.isHidden = false
            }
            let Sound3 = SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false)
            let Sound4 = SKAction.playSoundFileNamed("yes5.wav", waitForCompletion: false)
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
    
    func navigateToNumber6() {
        GameProgress.shared.saveProgress(for: 1, subLevel: 5)

        if let number2Scene = SKScene(fileNamed: "Numberr6") as? BaseScene{
            number2Scene.scaleMode = .aspectFill
            number2Scene.adjustSceneSize(for: self.view!)
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(number2Scene, transition: transition)}
    }
    }


