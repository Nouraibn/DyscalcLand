import SpriteKit

class Sub1: SKScene {
    
    
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
    var LabelNode : SKLabelNode!
    
    var bowlingArray : [SKSpriteNode] = []
    var bowlingArrayLabel : [SKLabelNode] = []

    
    var counter: Int = 0
    

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
        LabelNode = self.childNode(withName: "LabelNode") as? SKLabelNode
        
        
        
        for i in 1..<8 {
            
            if let bowling = self.childNode(withName: "Bowling\(i)") as? SKSpriteNode {
                bowlingArray.append(bowling)
                bowling.zPosition = 1
            }
            if let bowlingLabel = self.childNode(withName: "LabelNode\(i)") as? SKLabelNode {
                bowlingArrayLabel.append(bowlingLabel)
                bowlingLabel.isHidden = true //hide the label so it dosent show the word Label
                bowlingLabel.zPosition = 2
                bowlingLabel.text = "\(i)"
            }
        }
        
        
        // Ensure Background and Border are not nil and set positions

        background?.zPosition = -2
        bourd?.zPosition = -1
        
        
        // Set the initial state for other nodes
        
        
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
        LabelNode?.isHidden = true
        
        // func toches begin يشوف اذا اللمسه علا البولنق \
        
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: self)
                
                for bowling in bowlingArray {
                    if bowling.contains(location) {
                        showLabel()
                    }
                }
               
               func showLabel(){
                   
                    LabelNode?.isHidden = false
                }
             
            }
        }
        
//not hideen
        
        
    }
    
    
    
    
    
    
    
    
    
    
}
    
