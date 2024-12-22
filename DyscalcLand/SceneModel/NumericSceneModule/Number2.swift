
import SpriteKit

class Number2: SKScene {
    
    var background: SKSpriteNode!
       var num2Balloon: SKSpriteNode!
       var balloon1: SKSpriteNode!
       var balloon2: SKSpriteNode!
       var border: SKSpriteNode!
       var popBalloon1: SKSpriteNode!
       var popBalloon2: SKSpriteNode!
       var guidingLabel: SKLabelNode!
       var equalLabel: SKLabelNode!
       
       override func didMove(to view: SKView) {
           // Initialize nodes from the .sks file
           background = self.childNode(withName: "Background") as? SKSpriteNode
           num2Balloon = self.childNode(withName: "Num2Balloon") as? SKSpriteNode
           balloon1 = self.childNode(withName: "Balloon1") as? SKSpriteNode
           balloon2 = self.childNode(withName: "Balloon2") as? SKSpriteNode
           border = self.childNode(withName: "Border") as? SKSpriteNode
           popBalloon1 = self.childNode(withName: "PopBalloon1") as? SKSpriteNode
           popBalloon2 = self.childNode(withName: "PopBalloon2") as? SKSpriteNode
           guidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
           equalLabel = self.childNode(withName: "Equal") as? SKLabelNode
       }
}
