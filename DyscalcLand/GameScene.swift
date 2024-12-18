

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    var cottonCandies: [SKSpriteNode] = []
    var numberCottonCandy: [SKLabelNode] = []
    var cottonCandyCart: SKSpriteNode!
    var mainEquation: SKLabelNode!
    
    var currentNumberIndex = 0 // to see which cotton candy is preseed
    
    override func didMove(to view: SKView) {
        
        let cottonCandyCart = self.childNode(withName: "CottonCandyCart") as! SKSpriteNode
        let mainEquation = self.childNode(withName: "Equation") as! SKLabelNode
        
        for i in 1..<6 {
            
            if let cottonCandy = self.childNode(withName: "PinkCottonCandy\(i)") as? SKSpriteNode {
                            cottonCandies.append(cottonCandy)
                cottonCandy.zPosition = 1
            }
            if let numLabel = self.childNode(withName: "Num\(i)") as? SKLabelNode {
                numberCottonCandy.append(numLabel)
                numLabel.isHidden = true //hide the label so it dosent show the word Label
                numLabel.zPosition = 2
                numLabel.text = "\(i)"
            }
        }
        cottonCandyCart.zPosition = 0

        mainEquation.text = "2 + 3 = ?" // initial
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            //see if the touch was on the cotton candy
            for (index, cottonCandy) in cottonCandies.enumerated() {
                if cottonCandy.contains(touchLocation) {
                    numberCottonCandy[index].isHidden = false //show label when the user click on the cotton candy
                }
            }
        }
    }
        
    }
            
