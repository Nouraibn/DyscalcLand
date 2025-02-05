import SpriteKit
import SwiftData

class ClownMap: BaseScene {
    
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
    
    // Static property to track if it's the first time the scene is opened
    static var isFirstTime = true
    static var fromSub2 = false

    // Static property to track specific navigation states
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

        if let cloudLabel = cloudLabel {
            cloudLabel.fontName = "ComicSansMS-Bold"
            cloudLabel.text = "Lets start playing \n    with Clown"
            cloudLabel.fontSize = 24
            
            // Enable line breaks by setting the max width for the label
            cloudLabel.horizontalAlignmentMode = .center
            cloudLabel.verticalAlignmentMode = .center

            // Set the maximum width for the label (ensures line breaks occur)
            cloudLabel.preferredMaxLayoutWidth = 300 // Adjust based on your scene's layout

            // Set the number of lines to 0 for multiline support
            cloudLabel.numberOfLines = 0
        }
        // Set initial zPositions
        background2?.zPosition = -1
        clown?.zPosition = 1
        cloudLabel?.zPosition = 2
        openN?.zPosition = 2
        openA?.zPosition = 2

        // Hide nodes initially
        clown?.alpha = 0.0
        luckA?.alpha = 0.0
        luckS?.alpha = 0.0
        openA?.alpha = 0.0
        openN?.alpha = 0.0
        openS?.alpha = 0.0
        winA?.alpha = 0.0
        winN?.alpha = 0.0
        winS?.alpha = 0.0
       

        updateUIState()

        // Animate the balls
        animateBalls()
        addPulsingAnimation(to: openN)
        addPulsingAnimation(to: openA)
        addPulsingAnimation(to: openS)
    }

    private func updateUIState() {
        luckA?.isHidden = false
        luckS?.isHidden = false
        openN?.isHidden = false
        winN?.isHidden = true
        winA?.isHidden = true
        winS?.isHidden = true
        openS?.isHidden = true
        openA?.isHidden = true
        cloud?.isHidden = true
        cloudLabel.isHidden = true
        
        // Handle conditions based on ClownMap properties
        if ClownMap.Equation5 {
            
            let delay2 = SKAction.wait(forDuration: 2.0) // Wait for 3 seconds
            let playSound2 = SKAction.playSoundFileNamed("Excellentnext.wav", waitForCompletion: false)
            let clap1 = SKAction.playSoundFileNamed("Clapping.mp3", waitForCompletion: false)
            let delayedSound2 = SKAction.sequence([delay2,clap1, playSound2])
            self.run(delayedSound2)
            
            winN?.isHidden = false
            winA?.isHidden = false
            openS?.isHidden = false
            openA?.isHidden = true
            openN?.isHidden = true
            luckA?.isHidden = true
            luckS?.isHidden = true
            winS?.isHidden = true
            ClownMap.Equation5 = false
        } else if ClownMap.navigatedFromNumber10 {
            
            let delay1 = SKAction.wait(forDuration: 2.0) // Wait for 3 seconds
            let playSound1 = SKAction.playSoundFileNamed("Excellentnext.wav", waitForCompletion: false)
            let clap = SKAction.playSoundFileNamed("Clapping.mp3", waitForCompletion: false)
            let delayedSound1 = SKAction.sequence([delay1,clap,playSound1])
            self.run(delayedSound1)
            
            winN?.isHidden = false
            openN?.isHidden = true
            openA?.isHidden = false
            luckA?.isHidden = true
            winA?.isHidden = true
            winS?.isHidden = true
            openS?.isHidden = true
            ClownMap.navigatedFromNumber10 = false
        }
        if ClownMap.fromSub2{
            let delay3 = SKAction.wait(forDuration: 5.0) // Wait for 3 seconds
            let playSound3 = SKAction.playSoundFileNamed("ENExellent.wav", waitForCompletion: false)
            let clap = SKAction.playSoundFileNamed("Clapping.mp3", waitForCompletion: false)
            let delayedAction = SKAction.sequence([delay3, playSound3,clap])
            self.run(delayedAction)
        
            winN?.isHidden = false
            openN?.isHidden = true
            openA?.isHidden = true
            luckA?.isHidden = true
            winA?.isHidden = false
            winS?.isHidden = false
            openS?.isHidden = true
            luckA?.isHidden = true
            luckS?.isHidden = true
            ClownMap.fromSub2 = false
            
        }
        
        if ClownMap.isFirstTime{
            ClownMap.isFirstTime = false
            cloud?.isHidden = false
            cloudLabel?.isHidden = false
            cloud?.alpha = 0.0
            cloudLabel?.alpha = 0.0
            let delay2 = SKAction.wait(forDuration: 2.0)
            let group =  SKAction.run {
                self.cloudLabel?.run(SKAction.fadeIn(withDuration: 1.0))
                self.cloud?.run(SKAction.fadeIn(withDuration: 1.0))}
            let delayedAction = SKAction.sequence([delay2, group])
            self.run(delayedAction)
            
            let delay = SKAction.wait(forDuration: 2.0) // Wait for 3 seconds
            let playSound = SKAction.playSoundFileNamed("Clown.wav", waitForCompletion: false)
            let delayedSound = SKAction.sequence([delay, playSound])

            self.run(delayedSound)
        }
    }

    func addPulsingAnimation(to node: SKNode) {
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.6) // Scale up by 20%
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.6) // Scale back to original size
        let pulse = SKAction.sequence([scaleUp, scaleDown]) // Create a sequence of actions
        let repeatPulse = SKAction.repeatForever(pulse) // Repeat the pulsing forever
        node.run(repeatPulse) // Apply the animation to the node
    }

    func animateBalls() {
        // Action to move up and fade out
        let moveUp = SKAction.moveBy(x: 0, y: 1000, duration: 2.0) // Move up off the screen
        let fadeOut = SKAction.fadeOut(withDuration: 1.0) // Fade out while moving
        let group = SKAction.group([moveUp, fadeOut]) // Combine actions

      
        // Action to reveal fixed nodes
        let revealFixedNodes = SKAction.run {
            self.clown?.run(SKAction.fadeIn(withDuration: 1.0))
            self.openA?.run(SKAction.fadeIn(withDuration: 1.0))
            self.luckS?.run(SKAction.fadeIn(withDuration: 1.0))
            self.luckA?.run(SKAction.fadeIn(withDuration: 1.0))
            self.openN?.run(SKAction.fadeIn(withDuration: 1.0))
            self.winN?.run(SKAction.fadeIn(withDuration: 1.5))
            self.openS?.run(SKAction.fadeIn(withDuration: 1.0))
            self.winA?.run(SKAction.fadeIn(withDuration: 1.0))
            self.winS?.run(SKAction.fadeIn(withDuration: 1.0))
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let node = self.atPoint(touchLocation)

            // Check if the OpenN node is tapped
            if node == openN {
                run(SKAction.playSoundFileNamed("Button.mp3", waitForCompletion: false))
                goToNumeric()
            }
            if node == openA {
                GameProgress.shared.saveProgress(for: 2, subLevel: 1)
                run(SKAction.playSoundFileNamed("Button.mp3", waitForCompletion: false))
                goToAddition()
            }
            if node == openS {
                GameProgress.shared.saveProgress(for: 3, subLevel: 1)
                run(SKAction.playSoundFileNamed("Button.mp3", waitForCompletion: false))
                goToSubtraction()
            }
        }
    }

    func goToNumeric() {
        let gameProgress = GameProgress.shared
        let mainLevel = 1

        if let currentMainLevel = gameProgress.mainLevels[mainLevel] {
            let subLevel = currentMainLevel.currentSubLevel

            if subLevel >= 1 && subLevel <= currentMainLevel.totalSubLevels {
                let sceneName = "Number\(subLevel)"
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
        let gameProgress = GameProgress.shared
        let mainLevel = 2

        // Static variable to track if this function has been called before
        var isFirstCall = true

        if isFirstCall {
            isFirstCall = false
            GameProgress.shared.saveProgress(for: mainLevel, subLevel: 1)
        }

        if let currentMainLevel = gameProgress.mainLevels[mainLevel] {
            let subLevel = currentMainLevel.currentSubLevel

            let subLevelNames = [
                "DragAndDrop1", "Equation1", "DragAndDrop2", "Equation2",
                "DragAndDrop3", "Equation3", "DragAndDrop4", "Equation4",
                "DragAndDrop5", "Equation5"
            ]

            if subLevel >= 1 && subLevel <= currentMainLevel.totalSubLevels {
                let sceneName = subLevelNames[subLevel - 1]
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
        let gameProgress = GameProgress.shared
        let mainLevel = 3

        // Static variable to track if this function has been called before
        var isFirstCall = true

        if isFirstCall {
            isFirstCall = false
            GameProgress.shared.saveProgress(for: mainLevel, subLevel: 1)
        }

        if let currentMainLevel = gameProgress.mainLevels[mainLevel] {
            let subLevel = currentMainLevel.currentSubLevel

            if subLevel >= 1 && subLevel <= currentMainLevel.totalSubLevels {
                let sceneName = "Sub\(subLevel)"
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

}
