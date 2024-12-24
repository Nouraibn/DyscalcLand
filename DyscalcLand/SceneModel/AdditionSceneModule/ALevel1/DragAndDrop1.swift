
import SpriteKit

class DragAndDrop1: SKScene {
    
    var cottonCandies: [SKSpriteNode] = []
    var cottonCandyCart: SKSpriteNode!
    var background2: SKSpriteNode!
    var progressBar: SKSpriteNode!
    
    var cottonCandyCount: Int = 0
    let maxCottonCandyCount = 3
    let cottonCandySpacing: CGFloat = 30
    
    override func didMove(to view: SKView) {
        background2 = SKSpriteNode(imageNamed: "background2")
        cottonCandyCart = SKSpriteNode(imageNamed: "cottonCandyCart")
        progressBar = childNode(withName: "progressBar") as? SKSpriteNode

        
        for i in 1..<maxCottonCandyCount + 1 {
            if let yellowCottonCandy = childNode(withName: "YellowCottonCandy\(i)") as? SKSpriteNode {
                cottonCandies.append(yellowCottonCandy)
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            for yellowCottonCandy in cottonCandies {
                if yellowCottonCandy.contains(location) {
                    yellowCottonCandy.alpha = 0.5
                    yellowCottonCandy.zPosition = 10 // Bring it to the front
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // Move the dragged cotton candy
            for yellowCottonCandy in cottonCandies {
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
            for yellowCottonCandy in cottonCandies {
                if yellowCottonCandy.alpha == 0.5 && cottonCandyCart.frame.contains(location) {
                    // Successfully dropped the cotton candy in the cart
                    yellowCottonCandy.alpha = 1.0 // Restore opacity
                    yellowCottonCandy.position = cottonCandyCart.position // Place it inside the cart
                    yellowCottonCandy.zPosition = 1
                    
                    // Increment the cotton candy count and update the progress bar
                    cottonCandyCount += 1
                    updateProgressBar()
                }
            }
        }
    }
    func updateProgressBar() {
            let progress = CGFloat(cottonCandyCount) / CGFloat(maxCottonCandyCount)
            progressBar.size.width = progress * 200
        }
    }

