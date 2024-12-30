import SpriteKit
import SwiftData


class ClownMap: SKScene {
    
    var parentController: GameViewController?
    
    // Nodes for fixed assets
    private var background2: SKSpriteNode!
    private var clown: SKSpriteNode!
    private var luckS: SKSpriteNode!
    private var luckA: SKSpriteNode!
    private var openN: SKSpriteNode!
    private var cloud: SKSpriteNode! // New node
    private var cloudLabel: SKLabelNode! // New node
    private var winN: SKSpriteNode! // New node
    private var winA: SKSpriteNode! // New node
    private var winS: SKSpriteNode! // New node
    private var openA: SKSpriteNode! // New node
    private var openS: SKSpriteNode!
    
    // Static property to track if navigation is from Number10
  
    static var navigatedFromNumber10 = false
    static var Equation5 = false
    
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
       
        winA = self.childNode(withName: "WinA") as? SKSpriteNode
        openA = self.childNode(withName: "OpenA") as? SKSpriteNode
        openS = self.childNode(withName: "OpenS") as? SKSpriteNode 
        winS = self.childNode(withName: "WinS") as? SKSpriteNode
        
        // Set initial zPositions
        background2?.zPosition = -1
        clown?.zPosition = 1
        cloudLabel?.zPosition = 2
        openN?.zPosition = 2
        openA?.zPosition = 2
        
        // Hide nodes initially
        clown?.alpha = 0.0
        luckS?.alpha = 0.0
        luckA?.alpha = 0.0
        openN?.alpha = 0.0
        cloud?.alpha = 0.0
        winN?.alpha = 0.0
        cloudLabel?.alpha = 0.0
        openA.alpha = 0.0
        winA?.alpha = 0.0
        openS?.alpha = 0.0
                
        
        updateUIState()
        
        func updateUIState() {
            // Reset all nodes to hidden state by default
            winN?.isHidden = true
            winA?.isHidden = true
            winS?.isHidden = true
            openS?.isHidden = true
            openA?.isHidden = true
            openN?.isHidden = true
            luckA?.isHidden = true
            luckS?.isHidden = true

            // Handle conditions based on ClownMap properties
            if ClownMap.Equation5 {
                winN?.isHidden = false
                winA?.isHidden = false
                openS?.isHidden = false
                openA?.isHidden = true
                openN?.isHidden = true
                luckA?.isHidden = true
                luckS?.isHidden = true
                winS?.isHidden = true
            } else if ClownMap.navigatedFromNumber10 {
                winN?.isHidden = false
                openN?.isHidden = true
                openA?.isHidden = false
                luckA?.isHidden = true
                winA?.isHidden = true
                winS?.isHidden = true
                openS?.isHidden = true
            }
        }
        

        
        // Animate the balls
        animateBalls()
        addPulsingAnimation(to: openN)
        addPulsingAnimation(to: openA)
        addPulsingAnimation(to: openS)
       
    }
   

    
    func addPulsingAnimation(to node: SKNode) {
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.6) // Scale up by 20%
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.6) // Scale back to original size
        let pulse = SKAction.sequence([scaleUp, scaleDown]) // Create a sequence of actions
        let repeatPulse = SKAction.repeatForever(pulse) // Repeat the pulsing forever
        node.run(repeatPulse) // Apply the animation to the node
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
            self.openA?.run(SKAction.fadeIn(withDuration: 1.0))
            self.luckS?.run(SKAction.fadeIn(withDuration: 1.0))
            self.luckA?.run(SKAction.fadeIn(withDuration: 1.0))
            self.openN?.run(SKAction.fadeIn(withDuration: 1.0))
            self.cloudLabel?.run(SKAction.fadeIn(withDuration: 1.0))
            self.cloud?.run(SKAction.fadeIn(withDuration: 1.0))
            self.winN?.run(SKAction.fadeIn(withDuration: 1.5))
            self.openS?.run(SKAction.fadeIn(withDuration: 1.0))
            self.winA?.run(SKAction.fadeIn(withDuration: 1.0))
            self.winS?.run(SKAction.fadeIn(withDuration: 1.0))
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
                goToNumeric()
            }
            if node == openA {
                
                goToAddition()
            }
            if node == openS {
                
                goToSubtraction()
            }
                        }
        }
        
        // Function to navigate to the Number1 scene
    func goToNumeric() {
        // Access the shared GameProgress instance
        let gameProgress = GameProgress.shared
        
        // Assume we are working with mainLevel 1 for now
        let mainLevel = 1
        
        // Retrieve the main level from GameProgress
        if let currentMainLevel = gameProgress.mainLevels[mainLevel] {
            let subLevel = currentMainLevel.currentSubLevel
            
            // Ensure subLevel is valid
            if subLevel >= 1 && subLevel <= currentMainLevel.totalSubLevels {
                let sceneName = "Number\(subLevel)" // Construct the scene name dynamically
                
                if let nextScene = SKScene(fileNamed: sceneName) {
                    nextScene.scaleMode = .aspectFill
                    let transition = SKTransition.fade(withDuration: 1.0)
                    self.view?.presentScene(nextScene, transition: transition)
                } else {
                    print("Error: Scene \(sceneName) not found!")
                }
            } else {
                print("Error: Sub Level \(subLevel) is out of range for Main Level \(mainLevel).")
            }
        } else {
            print("Error: Main Level \(mainLevel) not found in progress.")
        }
    }

    
    func goToAddition() {
        // Access the shared GameProgress instance
        let gameProgress = GameProgress.shared

        // Define the main level for addition scenes
        let mainLevel = 2

        // Retrieve the main level from GameProgress
        if let currentMainLevel = gameProgress.mainLevels[mainLevel] {
            let subLevel = currentMainLevel.currentSubLevel
            
            // Define the sub-level scene names for mainLevel 2
            let subLevelNames = [
                "DragAndDrop1", "Equation1", "DragAndDrop2", "Equation2",
                "DragAndDrop3", "Equation3", "DragAndDrop4", "Equation4",
                "DragAndDrop5", "Equation5"
            ]
            
            // Ensure the sub-level is within the valid range
            if subLevel > 0 && subLevel <= subLevelNames.count {
                let sceneName = subLevelNames[subLevel - 1] // Get the scene name for the current sub-level
                
                if let nextScene = SKScene(fileNamed: sceneName) {
                    nextScene.scaleMode = .aspectFill
                    let transition = SKTransition.fade(withDuration: 0.1)
                    self.view?.presentScene(nextScene, transition: transition)
                } else {
                    print("Error: Scene \(sceneName) not found!")
                }
            } else {
                print("Error: Sub Level \(subLevel) is out of range for Main Level \(mainLevel).")
            }
        } else {
            print("Error: Main Level \(mainLevel) not found in progress.")
        }
    }

    func goToSubtraction() {
        let nextScene = SKScene(fileNamed: "Sub1")
        if let nextScene = nextScene {
            nextScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 0.1)
            self.view?.presentScene(nextScene, transition: transition)
        }
    }
        }
    
