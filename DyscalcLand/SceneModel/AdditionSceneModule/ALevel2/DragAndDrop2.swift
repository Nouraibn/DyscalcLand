
import SpriteKit

class DragAndDrop2: SKScene {
    
    var yellowCottonCandies: [SKSpriteNode] = []
    var pinkCottonCandies: [SKSpriteNode] = []
    var cottonCandyCart: SKSpriteNode!
    var background2: SKSpriteNode!
    
    var cottonCandyCount: Int = 0
    let maxCottonCandyCount = 2
    let cottonCandySpacing: CGFloat = 60
    
    override func didMove(to view: SKView) {
        background2 = childNode(withName: "Background2") as? SKSpriteNode
        cottonCandyCart = childNode(withName: "CottonCandyCart") as? SKSpriteNode
        background2.zPosition = -1
       
        
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
        }
    }

}

    

