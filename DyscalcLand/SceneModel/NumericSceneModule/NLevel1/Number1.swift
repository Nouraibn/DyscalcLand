import SpriteKit
import SwiftData
import UIKit

class Number1: BaseScene {
    
  

  
    // Nodes for fixed assets
    var Background: SKSpriteNode!
    var Border: SKSpriteNode!
    var Balloon: SKSpriteNode!
    var Num1Balloon: SKSpriteNode!
    var PopBalloon: SKSpriteNode!
    var EqualLabel: SKSpriteNode!
    var GuidingLabel: SKLabelNode!
    var NextButton: SKSpriteNode! // New node for navigation button
    var NextLabel: SKLabelNode! // New node for navigation label
    var Click: SKSpriteNode!
    var NumBalloon: SKSpriteNode!
    var EndLabel: SKLabelNode!
    

    override func didMove(to view: SKView) {
        
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        
        // Load fixed nodes from the scene
        Background = self.childNode(withName: "Background2") as? SKSpriteNode
        Border = self.childNode(withName: "Border2") as? SKSpriteNode
        Balloon = self.childNode(withName: "Balloon") as? SKSpriteNode
        Num1Balloon = self.childNode(withName: "ABalloon1") as? SKSpriteNode
        NumBalloon = self.childNode(withName: "Num1Balloon") as? SKSpriteNode
        PopBalloon = self.childNode(withName: "PopBalloon") as? SKSpriteNode
        EqualLabel = self.childNode(withName: "Equal") as? SKSpriteNode
        GuidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
        NextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        Click = self.childNode(withName: "Click") as? SKSpriteNode// Load the new button node
        NextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode // Load the new label node
        
        EndLabel = self.childNode(withName: "EndLabel") as? SKLabelNode
        
        for family in UIFont.familyNames {
            print("Font family: \(family)")
            for fontName in UIFont.fontNames(forFamilyName: family) {
                print(" - Font name: \(fontName)")
            }
        }

        if let guidingLabel = GuidingLabel {
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

           if let nextLabel = NextLabel {
               nextLabel.fontName = "ComicSansMS-Bold"
               nextLabel.text = "Next"
               nextLabel.fontSize = 30
           }
           
        if let endLabel = EndLabel {
            let fullText = "Yes, it's number One"
            
            // Create an attributed string
            let attributedString = NSMutableAttributedString(string: fullText)
            
            // Apply regular font to the entire string
            attributedString.addAttribute(.font, value: UIFont(name: "ComicSansMS", size: 32)!, range: NSRange(location: 0, length: fullText.count))
            
            // Define the range for the bold part (word "One")
            let boldRange = (fullText as NSString).range(of: "One")
            
            // Apply the bold font to "One" (keep the font size the same for both parts)
            attributedString.addAttribute(.font, value: UIFont(name: "ComicSansMS-Bold", size: 34)!, range: boldRange)
            
            // Set the attributed string to the label
            endLabel.attributedText = attributedString
        }



        
        // Ensure Background and Border are not nil and set positions
        Background?.zPosition = -2
        Border?.zPosition = -1
        GuidingLabel?.zPosition = 1
        Click?.zPosition = 2
        GuidingLabel?.zPosition = 3
        
        // Set the initial state for other nodes
        EndLabel?.isHidden = true
        Num1Balloon?.isHidden = true
        PopBalloon?.isHidden = true
        NumBalloon?.isHidden = true
        Balloon?.isHidden = false
        EqualLabel?.isHidden = false
        GuidingLabel?.isHidden = false
        NextButton?.isHidden = true // Initially hide the NextButton
        NextLabel?.isHidden = true // Initially hide the NextLabel
        
        addPulsingAnimation(to: NextButton)
        addPulsingAnimation(to: NextLabel)
        
        startOscillatingAnimation(for: Click, fromLeftOffset: 100, duration: 1.0)
         

        
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
        
        Balloon?.isHidden = true
        PopBalloon?.isHidden = false
    
        
        let Sound1 = SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false)
        let Sound2 = SKAction.playSoundFileNamed("E1.mp4", waitForCompletion: false)
        let delay = SKAction.wait(forDuration: 2.0)
        let revealAction = SKAction.run { [weak self] in
               self?.NumBalloon?.isHidden = false
               self?.EndLabel?.isHidden = false
           }
        let Sound3 = SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false)
        let Sound4 = SKAction.playSoundFileNamed("yes1.wav", waitForCompletion: false)
        let PlaySound = SKAction.sequence([Sound1, Sound2,delay,revealAction,Sound3, Sound4,])
        self.run(PlaySound)

       
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
        if let number2Scene = SKScene(fileNamed: "Number2") as? BaseScene{
            number2Scene.scaleMode = .aspectFill
            number2Scene.adjustSceneSize(for: self.view!)
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(number2Scene, transition: transition)}
         }
     }

