import SpriteKit

class DragAndDrop2: SKScene {
    
    var yellowCottonCandies: [SKSpriteNode] = []
    var pinkCottonCandies: [SKSpriteNode] = []
    var cottonCandyCart: SKSpriteNode!
    var background2: SKSpriteNode!
    var mainText: SKLabelNode!
    var nextButton: SKSpriteNode!
    var nextButtonLabel: SKLabelNode!
    
    var cottonCandyCount: Int = 0
    let maxCottonCandyCount = 2
    let cottonCandySpacing: CGFloat = 60
    
    override func didMove(to view: SKView) {
        background2 = childNode(withName: "Background2") as? SKSpriteNode
        cottonCandyCart = childNode(withName: "CottonCandyCart") as? SKSpriteNode
        mainText = childNode(withName: "MainText") as? SKLabelNode
        nextButton = childNode(withName: "NextButton") as? SKSpriteNode
        nextButtonLabel = childNode(withName: "ButtonLabel") as? SKLabelNode
        
        background2.zPosition = -1
//        mainText.zPosition = 10
        nextButton.zPosition = 1
        nextButtonLabel.zPosition = 1
        nextButton.isUserInteractionEnabled = true
        
        nextButton.alpha = 0.0
        nextButtonLabel.isHidden = true
        
        mainText.text = "Let’s Make Some Cotton Candies!"
        mainText.fontName = "Comic Sans MS"
        
        playSound()
        
        for i in 1...maxCottonCandyCount {
            if let yellowCottonCandy = childNode(withName: "YellowCottonCandy\(i)") as? SKSpriteNode {
                yellowCottonCandies.append(yellowCottonCandy)
            }
        }
        
        for i in 1..<2 {
            if let pinkCottonCandy = childNode(withName: "PinkCottonCandy\(i)") as? SKSpriteNode {
                pinkCottonCandies.append(pinkCottonCandy)
            }
        }
        
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0)
    }
    func playSound(){
        let sound = SKAction.playSoundFileNamed("AMakeCotton.mp3", waitForCompletion: false)
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
                    yellowCottonCandy.zPosition = 5
                    
                    yellowCottonCandy.texture = SKTexture(imageNamed: "PinkCottonCandy") // Change the yellow candy to pink cotton candy

                    cottonCandyCount += 1
                }
            }
            
            // Show next button when the task is complete
            if cottonCandyCount == maxCottonCandyCount {
                mainText.text = "Well Done!"
                mainText.fontSize = 24
                mainText.fontColor = .black
                mainText.fontName = "Comic Sans MS"
                
                // Show the next button after 3 seconds
                let waitAction = SKAction.wait(forDuration: 3.0)
                let showButtonAction = SKAction.run {
                    self.showNextButton()
                }
                let sequence = SKAction.sequence([waitAction, showButtonAction])
                self.run(sequence)
            }
            
            // Check if the user clicks the next button
            if nextButton.alpha > 0.0 && nextButton.contains(location) {
                goToEquation2Screen()
            }
        }
    }
    
    // Function to show the "Next" button
    func showNextButton() {
        nextButton.alpha = 1.0 // Show the next button
        nextButtonLabel.isHidden = false // Make the button label visible
    }
    
    // Function to go to Equation2 screen
    func goToEquation2Screen() {
        if let nextScene = SKScene(fileNamed: "Equation2") {
            nextScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 0.1)
            self.view?.presentScene(nextScene, transition: transition)
        }
    }
}
