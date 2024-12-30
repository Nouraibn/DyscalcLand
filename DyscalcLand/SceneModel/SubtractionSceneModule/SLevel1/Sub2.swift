import SpriteKit

class Sub2 : SKScene {
    
    
    
    var background : SKSpriteNode!
    var bourd : SKSpriteNode!
    var bowling1 : SKSpriteNode!
    var bowling2 : SKSpriteNode!
    var bowling3 : SKSpriteNode!
    var bowling4 : SKSpriteNode!
    var bowling5 : SKSpriteNode!
    var bowling6 : SKSpriteNode!
    var bowling7 : SKSpriteNode!
    var Next : SKSpriteNode!
    var tiket1 : SKSpriteNode!
    var tiket2 : SKSpriteNode!
    var tiket3 : SKSpriteNode!
    var bourdLablel : SKLabelNode!
    var NextLablel : SKLabelNode!
    var tiketLablel : SKLabelNode!
    var Bowling1Drop : SKSpriteNode!
    var Bowling2Drop : SKSpriteNode!
    var Qustion : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        // Load fixed nodes from the scene

        background = self.childNode(withName: "background") as? SKSpriteNode
        bourd = self.childNode(withName: "bourd") as? SKSpriteNode
        bourdLablel = self.childNode(withName: "bourdLablel") as? SKLabelNode
        Next = self.childNode(withName: "Next") as? SKSpriteNode
        NextLablel = self.childNode(withName: "NextLablel") as? SKLabelNode
        bowling1 = self.childNode(withName: "bowling1") as? SKSpriteNode
        bowling2 = self.childNode(withName: "bowling2") as? SKSpriteNode
        bowling3 = self.childNode(withName: "bowling3") as? SKSpriteNode
        bowling4 = self.childNode(withName: "bowling4") as? SKSpriteNode
        bowling4 = self.childNode(withName: "bowling5") as? SKSpriteNode
        bowling6 = self.childNode(withName: "bowling6") as? SKSpriteNode
        bowling7 = self.childNode(withName: "bowling7") as? SKSpriteNode
        tiket1 = self.childNode(withName: "tiket1") as? SKSpriteNode
        tiket2 = self.childNode(withName: "tiket2") as? SKSpriteNode
        tiket3 = self.childNode(withName: "tiket3") as? SKSpriteNode
        tiketLablel = self.childNode(withName: "tiketLablel") as? SKLabelNode
        Bowling1Drop = self.childNode(withName: "Bowling1Drop") as? SKSpriteNode
        Bowling2Drop = self.childNode(withName: "Bowling2Drop") as? SKSpriteNode
        Qustion = self.childNode(withName: "Qustion") as? SKSpriteNode
        
        
        
        background?.zPosition = -2
        bourd?.zPosition = -1
        
                
        bourdLablel?.isHidden = false
        bowling1?.isHidden = false
        bowling2?.isHidden = false
        bowling3?.isHidden = false
        bowling4?.isHidden = false
        bowling5?.isHidden = false
        bowling6?.isHidden = false
        bowling7?.isHidden = false
        tiket1?.isHidden = true
        tiket2?.isHidden = true
        tiket3?.isHidden = true
        Next?.isHidden = true
        NextLablel?.isHidden = true
        tiketLablel?.isHidden = true
        Bowling1Drop?.isHidden = true
        Bowling2Drop?.isHidden = true
        Qustion?.isHidden = true
        
        
        
        
        
    }
    
    
    
 
    
    
}
    



