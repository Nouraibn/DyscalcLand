import SpriteKit
import SwiftData


class ClownMap: SKScene {
    
    // Nodes for fixed assets
    private var background2: SKSpriteNode!
       private var clown: SKSpriteNode!
       private var luckS: SKSpriteNode!
       private var luckA: SKSpriteNode!
       private var openN: SKSpriteNode!
       private var cloud: SKSpriteNode! // New node
       private var cloudLabel: SKLabelNode! // New node
       private var winN: SKSpriteNode! // New node
       private var selectBorder: SKSpriteNode! // New node
    
    // Static property to track if navigation is from Number10
    var modelContext: ModelContext!
        static var navigatedFromNumber10 = false
    
    override func didMove(to view: SKView) {
        
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0

        // Load fixed nodes from the scene
        background2 = self.childNode(withName: "Background2") as? SKSpriteNode
               clown = self.childNode(withName: "Clown") as? SKSpriteNode
               luckS = self.childNode(withName: "LuckS") as? SKSpriteNode
               luckA = self.childNode(withName: "LuckA") as? SKSpriteNode
               openN = self.childNode(withName: "OpenN") as? SKSpriteNode
               cloud = self.childNode(withName: "Cloud") as? SKSpriteNode // Load Cloud node
               cloudLabel = self.childNode(withName: "CloudLabel") as? SKLabelNode // Load CloudLabel node
               winN = self.childNode(withName: "WinN") as? SKSpriteNode // Load WinN node
               selectBorder = self.childNode(withName: "SelectBorder") as? SKSpriteNode // Load SelectBorder node
               
        
        // Set initial zPositions
        background2?.zPosition = -1
        clown?.zPosition = 1
        cloudLabel?.zPosition = 2
        selectBorder?.zPosition = 1
        openN?.zPosition = 2
        
        // Hide nodes initially
        clown?.alpha = 0.0
        luckS?.alpha = 0.0
        luckA?.alpha = 0.0
        openN?.alpha = 0.0
        cloud?.alpha = 0.0
        winN?.alpha = 0.0
        cloudLabel?.alpha = 0.0
        selectBorder?.alpha = 0.0
        
        if ClownMap.navigatedFromNumber10 {
            winN?.isHidden = false
            selectBorder?.isHidden = true
            openN?.isHidden = true
               } else {
                   winN?.isHidden = true // Keep WinN hidden
               }
        
        // Animate the balls
        animateBalls()
    }
    
    // Function to animate balls and reveal other nodes
    func animateBalls() {
        // Action to move up and fade out
        let moveUp = SKAction.moveBy(x: 0, y: 1000, duration: 3.0) // Move up off the screen
        let fadeOut = SKAction.fadeOut(withDuration: 2.0) // Fade out while moving
        let group = SKAction.group([moveUp, fadeOut]) // Combine actions
        
        let sound = SKAction.playSoundFileNamed("Clown.wav", waitForCompletion: false)

        
        // Action to reveal fixed nodes
        let revealFixedNodes = SKAction.run {
            self.clown?.run(SKAction.fadeIn(withDuration: 1.0))
            self.luckS?.run(SKAction.fadeIn(withDuration: 1.0))
            self.luckA?.run(SKAction.fadeIn(withDuration: 1.0))
            self.openN?.run(SKAction.fadeIn(withDuration: 1.0))
            self.cloudLabel?.run(SKAction.fadeIn(withDuration: 1.0))
            self.selectBorder?.run(SKAction.fadeIn(withDuration: 1.0))
            self.cloud?.run(SKAction.fadeIn(withDuration: 1.0))
            self.winN?.run(SKAction.fadeIn(withDuration: 1.0))
        }
        
        // Sequence: Animate balls, then reveal fixed nodes
        let sequence = SKAction.sequence([group, revealFixedNodes, sound])
        
        // Animate all balls
        self.enumerateChildNodes(withName: "BlueBall*", using: { node, _ in
            node.run(sequence)
        })
        
        self.enumerateChildNodes(withName: "PinkBall*", using: { node, _ in
            node.run(sequence)
        })
        
        self.enumerateChildNodes(withName: "YellowBall*", using: { node, _ in
            node.run(sequence)
        })
    }
    
    // Handle touch events to navigate when the OpenN node is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let node = self.atPoint(touchLocation)
            
            // Check if the OpenN node is tapped
            if node == openN {
                goToNextScene()
            }
        }
    }
    
    // Function to navigate to the Number1 scene
    func goToNextScene() {
        guard let nextScene = SKScene(fileNamed: "Number1") else {
            return
        }
        nextScene.scaleMode = .aspectFill
        let transition = SKTransition.fade(withDuration: 1.0) // Fade transition
        self.view?.presentScene(nextScene, transition: transition)
    }
    
    func updateClownMap() {
        let fetchRequest = FetchDescriptor<GameProgress>()
        
        if let progress = try? modelContext.fetch(fetchRequest) {
            for level in progress {
                if level.levelID == 1 && level.partID == 1 && level.classID == 1 && level.isUnlocked {
                    openN?.isHidden = false // Example: Show openN if unlocked
                }
                if level.levelID == 2 && level.partID == 1 && level.isUnlocked {
                    luckA?.isHidden = false // Show luckA if unlocked
                }
                if level.levelID == 3 && level.isUnlocked {
                    luckS?.isHidden = false // Show luckS if unlocked
                }
            }
        }
    }
}
