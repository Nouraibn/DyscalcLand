import SpriteKit
import SwiftData

class Number10: SKScene {
    
    // Nodes from the .sks file
    var background: SKSpriteNode!
    var num10Balloon: SKSpriteNode!
    var balloons: [SKSpriteNode] = [] // Array for balloons
    var popBalloons: [SKSpriteNode] = [] // Array for popped balloons
    var border: SKSpriteNode!
    var guidingLabel: SKLabelNode!
    var equalLabel: SKLabelNode!
    var nextButton: SKSpriteNode! // New node for navigation button
    var nextLabel: SKLabelNode! // New node for navigation label
    
    // Flags to track progress
    var balloonPoppedFlags: [Bool] = [] // Array for balloon popped flags
    
    // Model context for saving progress
    var modelContext: ModelContext!
    
    override func didMove(to view: SKView) {
        
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        
        // Initialize nodes from the .sks file
        background = self.childNode(withName: "Background") as? SKSpriteNode
        num10Balloon = self.childNode(withName: "Num10Balloon") as? SKSpriteNode
        border = self.childNode(withName: "Border") as? SKSpriteNode
        guidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
        equalLabel = self.childNode(withName: "Equal") as? SKLabelNode
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        nextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode
        
        // Load balloons and pop balloons dynamically
        for i in 1...10 {
            if let balloon = self.childNode(withName: "Balloon\(i)") as? SKSpriteNode,
               let popBalloon = self.childNode(withName: "PopBalloon\(i)") as? SKSpriteNode {
                balloons.append(balloon)
                popBalloons.append(popBalloon)
                balloonPoppedFlags.append(false) // Initialize flags
                popBalloon.isHidden = true // Initially hide popped balloons
            }
        }
        
        background?.zPosition = -1
        border?.zPosition = -1
        num10Balloon.isHidden = true
        nextButton?.isHidden = true
        nextLabel?.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            // Check which balloon is tapped
            if let index = balloons.firstIndex(where: { $0 == node }) {
                handleBalloonTapped(index: index)
            } else if node == nextButton || node == nextLabel {
                navigateToClownMap()
            }
        }
    }
    
    func handleBalloonTapped(index: Int) {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        
        balloons[index].isHidden = true
        popBalloons[index].isHidden = false
        balloonPoppedFlags[index] = true
        
        checkCompletion()
    }
    
    func checkCompletion() {
        if balloonPoppedFlags.allSatisfy({ $0 }) {
            run(SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false))
            num10Balloon.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.nextButton?.isHidden = false
                self?.nextLabel?.isHidden = false
                self?.nextButton?.zPosition = 1
                self?.nextLabel?.zPosition = 2
            }
            
            do {
                try updateProgress()
            } catch {
                print("Error updating progress: \(error)")
            }
        }
    }
    
    func updateProgress() throws {
        let fetchRequest = FetchDescriptor<LevelProgress>(predicate: #Predicate { $0.level == 1 })
        
        if let levelProgress = try modelContext.fetch(fetchRequest).first {
            levelProgress.isComplete = true
            try modelContext.save()
        } else {
            print("Error: Level 1 progress not found!")
        }
    }
    
    func navigateToClownMap() {
        ClownMap.navigatedFromNumber10 = true
        if let clownMapScene = SKScene(fileNamed: "ClownMap") {
            clownMapScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(clownMapScene, transition: transition)
        }
    }
}
