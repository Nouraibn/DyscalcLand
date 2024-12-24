
import SpriteKit

class Equation1: SKScene {
    var cottonCandies: [SKSpriteNode] = []
    var numberCottonCandy: [SKLabelNode] = []
    var cottonCandyCart: SKSpriteNode!
    var mainEquation: SKLabelNode!
        var background2: SKSpriteNode!
    var mainText: SKLabelNode!
    
    var currentNumberIndex = 0 // to see which cotton candy is preseed
    
    override func didMove(to view: SKView) {
        
        cottonCandyCart = self.childNode(withName: "CottonCandyCart") as? SKSpriteNode
               mainEquation = self.childNode(withName: "Equation1") as? SKLabelNode
                background2 = self.childNode(withName: "Background2") as? SKSpriteNode
                self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
//        mainText.text = "Let’s count how many cotton candies there are"
//        mainText.fontName = "Comic Sans MS"
        
        for i in 1..<3 {
            
            if let cottonCandy = self.childNode(withName: "PinkCottonCandy\(i)") as? SKSpriteNode {
                cottonCandies.append(cottonCandy)
                cottonCandy.zPosition = 1
                print("CottonCandy\(i)")
            }
            if let numLabel = self.childNode(withName: "Num\(i)") as? SKLabelNode {
                numberCottonCandy.append(numLabel)
                numLabel.isHidden = true //hide the label so it dosent show the word Label
                numLabel.zPosition = 2
                numLabel.text = "\(i)"
                print("Num label \(i)")
            }
        }
        cottonCandyCart.zPosition = 0
                background2?.zPosition = -1
        mainEquation.zPosition = 4

        mainEquation.text = "1 + 1 ?" // initial
    }
    func updateEquation() {
        let baseEquation = "1 + 1 = "
        
        if currentNumberIndex < numberCottonCandy.count {
            let numText = numberCottonCandy[currentNumberIndex - 1].text ?? "?"
            mainEquation.text = "\(baseEquation)\(numText) ?"
        } else {
            let resultText = numberCottonCandy.last?.text ?? "?"
            mainEquation.text = "\(baseEquation)\(resultText)!"

        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            //see if the touch was on the cotton candy
            for (index, cottonCandy) in cottonCandies.enumerated() {
                            if cottonCandy.contains(touchLocation) {
                                
                                if currentNumberIndex < numberCottonCandy.count {
                                    let numText = numberCottonCandy[index]
                                    
                                    numText.isHidden = false
                                                           
                                                          
                                                           currentNumberIndex += 1
                                                           
                                                
                                                           updateEquation()
                                    
//                                    if currentNumberIndex == numberCottonCandy.count {
//                                        mainText.text = "You got it!"
//                                    }
                               
                    }
                    
                }
            }
        }
    }
    
}
            
