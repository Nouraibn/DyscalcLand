import SpriteKit

class DragAndDrop2: SKScene {
    
    var yellowCottonCandies: [SKSpriteNode] = []
    var pinkCottonCandies: [SKSpriteNode] = []
    var cottonCandyCart: SKSpriteNode!
    var background2: SKSpriteNode!
    var mainText: SKLabelNode!
    var cartLabel: SKLabelNode!
    
    var cottonCandyCount: Int = 0
    let maxCottonCandyCount = 2
    let cottonCandySpacing: CGFloat = 60
    
    var nextButton: SKSpriteNode!
    var nextButtonLabel: SKLabelNode!
    
    
    
    override func didMove(to view: SKView) {
        background2 = childNode(withName: "Background2") as? SKSpriteNode
        cottonCandyCart = childNode(withName: "CottonCandyCart") as? SKSpriteNode
        mainText = childNode(withName: "MainText") as? SKLabelNode
        cartLabel = childNode(withName: "CartLabel") as? SKLabelNode
        
        nextButton = childNode(withName: "NextButton") as? SKSpriteNode
        nextButtonLabel = childNode(withName: "ButtonLabel") as? SKLabelNode
//        nextButtonLabel.text = "Next"
        mainText.text = NSLocalizedString("Let’s Make Some Cotton Candies!", comment: "AddDraqAndDrop")
        
        cartLabel.text = NSLocalizedString("Cotton Candy", comment: "cart label")
        
        mainText.zPosition = 10
        cartLabel.zPosition = 10
        background2.zPosition = -1
        
        
        nextButton.alpha = 0.0
        nextButtonLabel.isHidden = true
       
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
            }
        }
        
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0)
        
        
      
    }
    func playSound(){
        let currentLanguage = Locale.preferredLanguages.first ?? "en" // if the language is not there default to english
        var soundFileName = "ENmakeCotton.wav" //default sound (english)
    
        if currentLanguage.prefix(2) == "ar" {// take the first letter
            soundFileName = "AMakeCotton.mp3"
        } else {
            soundFileName = "ENmakeCotton.wav"
        }
        
        
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

                    
                    cottonCandyCount += 1
                    
                    if cottonCandyCount == maxCottonCandyCount {
                        mainText.text = NSLocalizedString("Well Done!", comment: "bravo text")

                        
                        
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
    func showNextButton() {
        nextButton.alpha = 1.0 //make it show
        nextButtonLabel.isHidden = false
    }
    
    func goToEScreen() {
        
        GameProgress.shared.saveProgress(for: 2, subLevel: 3)
        let nextScene = SKScene(fileNamed: "Equation2")
        if let nextScene = nextScene {
            nextScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 0.1)
            self.view?.presentScene(nextScene, transition: transition)
        }
    }
    
}
