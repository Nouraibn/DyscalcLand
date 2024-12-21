import SpriteKit

class ClownMap: SKScene {
    
    // Nodes for fixed assets
    private var background2: SKSpriteNode!
    private var clown: SKSpriteNode!
    private var luckS: SKSpriteNode!
    private var luckA: SKSpriteNode!
    private var openN: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0

        // Load fixed nodes from the scene
        background2 = self.childNode(withName: "Background2") as? SKSpriteNode
        clown = self.childNode(withName: "Clown") as? SKSpriteNode
        luckS = self.childNode(withName: "LuckS") as? SKSpriteNode
        luckA = self.childNode(withName: "LuckA") as? SKSpriteNode
        openN = self.childNode(withName: "OpenN") as? SKSpriteNode
        
        // Set initial zPositions
        background2?.zPosition = -1
        clown?.zPosition = 1
        
        // Hide nodes initially
        clown?.alpha = 0.0
        luckS?.alpha = 0.0
        luckA?.alpha = 0.0
        openN?.alpha = 0.0
        
        // Animate the balls
        animateBalls()
    }
    
    // Function to animate balls and reveal other nodes
    func animateBalls() {
        // Action to move up and fade out
        let moveUp = SKAction.moveBy(x: 0, y: 1000, duration: 3.0) // Move up off the screen
        let fadeOut = SKAction.fadeOut(withDuration: 2.0) // Fade out while moving
        let group = SKAction.group([moveUp, fadeOut]) // Combine actions
        
        // Action to reveal fixed nodes
        let revealFixedNodes = SKAction.run {
            self.clown?.run(SKAction.fadeIn(withDuration: 1.0))
            self.luckS?.run(SKAction.fadeIn(withDuration: 1.0))
            self.luckA?.run(SKAction.fadeIn(withDuration: 1.0))
            self.openN?.run(SKAction.fadeIn(withDuration: 1.0))
        }
        
        // Sequence: Animate balls, then reveal fixed nodes
        let sequence = SKAction.sequence([group, revealFixedNodes])
        
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
}
