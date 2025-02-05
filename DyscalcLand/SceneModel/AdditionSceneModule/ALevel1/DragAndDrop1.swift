import SpriteKit

class DragAndDrop1: BaseScene {
    
    var yellowCottonCandies: [SKSpriteNode] = []
    var pinkCottonCandies: [SKSpriteNode] = []
    var cottonCandyCart: SKSpriteNode!
    var background2: SKSpriteNode!
    var mainText: SKLabelNode!
    var cartLabel: SKLabelNode!
    var hand:SKSpriteNode!
    var cottonCandyCount: Int = 0
    let maxCottonCandyCount = 1
    let cottonCandySpacing: CGFloat = 60
    
    var nextButton: SKSpriteNode!
    var nextButtonLabel: SKLabelNode!
    
    
    
    override func didMove(to view: SKView) {
        background2 = childNode(withName: "Background2") as? SKSpriteNode
        cottonCandyCart = childNode(withName: "CottonCandyCart") as? SKSpriteNode
        mainText = childNode(withName: "MainText") as? SKLabelNode
        cartLabel = childNode(withName: "CartLabel") as? SKLabelNode
        hand = childNode(withName: "Hand") as? SKSpriteNode
        nextButton = childNode(withName: "NextButton") as? SKSpriteNode
        nextButtonLabel = childNode(withName: "NextLabel") as? SKLabelNode
//        nextButtonLabel.text = "Next"
        if let guidingLabel = mainText {
            guidingLabel.fontName = "ComicSansMS-Bold"
            guidingLabel.text = "Lets make some Cutton \n        Candys!"
            guidingLabel.fontSize = 28
            
            // Enable line breaks by setting the max width for the label
            guidingLabel.horizontalAlignmentMode = .center
            guidingLabel.verticalAlignmentMode = .center

            // Set the maximum width for the label (ensures line breaks occur)
            guidingLabel.preferredMaxLayoutWidth = 500 // Adjust based on your scene's layout

            // Set the number of lines to 0 for multiline support
            guidingLabel.numberOfLines = 0
        }

           if let nextLabel = nextButtonLabel {
               nextLabel.fontName = "ComicSansMS-Bold"
               nextLabel.text = "Next"
               nextLabel.fontSize = 30
           }
           
        if let cart = cartLabel {
            cart.fontName = "ComicSansMS-Bold"
            cart.text = "Cotton Candy"
        }

        
        mainText.zPosition = 10
        cartLabel.zPosition = 10
        background2.zPosition = -1
        nextButton?.zPosition = 1
        nextButtonLabel?.zPosition = 2
        hand?.zPosition = 5
       
        
        nextButton.alpha = 0.0
        nextButtonLabel.isHidden = true
       
        startOscillatingAnimation(for: hand, fromLeftOffset: 450, duration: 1.0)
//        mainText.text = "Let’s Make Some Cotton Candies!"
        playSound()
        for i in 1...maxCottonCandyCount {
            if let yellowCottonCandy = childNode(withName: "YellowCottonCandy\(i)") as? SKSpriteNode {
                yellowCottonCandies.append(yellowCottonCandy)
            }
        }
        
        
            for i in 1..<2 {
                if let pinkCottonCandy = childNode(withName: "PinkCottonCandy\(i)") as? SKSpriteNode {
                    pinkCottonCandies.append(pinkCottonCandy)
                    pinkCottonCandy.isHidden = true
                }
            }
        
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0)
        
        
      
    }
    func playSound(){
      //  let currentLanguage = Locale.preferredLanguages.first ?? "en" // if the language is not there default to english
        let soundFileName = "ENmakeCotton.wav" //default sound (english)
    
      //  if currentLanguage.prefix(2) == "ar" {// take the first letter
        //    soundFileName = "AMakeCotton.mp3"
       // } else {
           // soundFileName = "ENmakeCotton.wav"
      //  }
        
        
        let sound = SKAction.playSoundFileNamed(soundFileName, waitForCompletion: false)
        self.run(sound)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // Check if touch is on any yellow cotton candy
            for yellowCottonCandy in yellowCottonCandies {
                if yellowCottonCandy.contains(location) {
                    yellowCottonCandy.alpha = 0.5
                    yellowCottonCandy.zPosition = 10
                    stopAndDisappear(for: hand)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // Move the dragged cotton candy
            for yellowCottonCandy in yellowCottonCandies {
                if yellowCottonCandy.alpha == 0.5 {
                    yellowCottonCandy.position = location
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // Check if the cotton candy is dropped inside the cart
            for yellowCottonCandy in yellowCottonCandies {
                if yellowCottonCandy.alpha == 0.5 && cottonCandyCart.frame.contains(location) {
                    yellowCottonCandy.alpha = 1.0 // Restore opacity
                    yellowCottonCandy.position = CGPoint(x: cottonCandyCart.position.x, y: cottonCandyCart.position.y + CGFloat(cottonCandyCount) * cottonCandySpacing) // Stack the candies
                    yellowCottonCandy.zPosition = 1
                    
                    yellowCottonCandy.texture = SKTexture(imageNamed: "PinkCottonCandy") // Change the yellow candy to pink cotton candy
                    yellowCottonCandy.isHidden = true
                    for pinkCottonCandy in pinkCottonCandies {
                           pinkCottonCandy.isHidden = false // Show the node
                       }
                    
                    cottonCandyCount += 1
                    
                    if cottonCandyCount == maxCottonCandyCount {
                        mainText.text = "Well Done!"
                        run(SKAction.playSoundFileNamed("ENExellent.wav", waitForCompletion: false))
                        run(SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false))

                        
                        
                        let waitAction = SKAction.wait(forDuration: 3.0)
                        let showButtonAction = SKAction.run {
                            self.showNextButton()
                        }
                        let sequence = SKAction.sequence([waitAction, showButtonAction])
                        self.run(sequence)
                    }
                }
            }
            
            if nextButton.alpha > 0.0 && nextButton.contains(location) {
                goToEScreen()
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
    func showNextButton() {
        nextButton.alpha = 1.0 //make it show
        nextButtonLabel.isHidden = false
    }
    
    func goToEScreen() {
        
        GameProgress.shared.saveProgress(for: 2, subLevel: 1)
        
        let nextScene = SKScene(fileNamed: "Equation1")
        if let nextScene = nextScene {
            nextScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 0.1)
            self.view?.presentScene(nextScene, transition: transition)
        }
    }
    
}
