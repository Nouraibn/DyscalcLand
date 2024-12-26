import SpriteKit
import SwiftData

class Number2: SKScene {
    
    // Nodes from the .sks file
    var background: SKSpriteNode!
    var num2Balloon: SKSpriteNode!
    var balloons: [SKSpriteNode] = []
    var popBalloons: [SKSpriteNode] = []
    var border: SKSpriteNode!
    var guidingLabel: SKLabelNode!
    var equalLabel: SKLabelNode!
    var nextButton: SKSpriteNode!
    var nextLabel: SKLabelNode!
    
    // Flags to track progress
    var balloonPoppedFlags: [Bool] = []
    
    // Model Context and Scene Parameters
    var modelContext: ModelContext?
    var levelID: Int = 1
    var partID: Int = 1
    var classID: Int = 2
    var nextClassID: Int = 3
    
    override func didMove(to view: SKView) {
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0

        // Initialize nodes from the .sks file
        background = self.childNode(withName: "Background") as? SKSpriteNode
        num2Balloon = self.childNode(withName: "Num2Balloon") as? SKSpriteNode
        border = self.childNode(withName: "Border") as? SKSpriteNode
        guidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
        equalLabel = self.childNode(withName: "Equal") as? SKLabelNode
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        nextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode

        // Load balloons and popBalloons
        for i in 1...5 { // Adjust based on the number of balloons
            if let balloon = self.childNode(withName: "Balloon\(i)") as? SKSpriteNode,
               let popBalloon = self.childNode(withName: "PopBalloon\(i)") as? SKSpriteNode {
                balloons.append(balloon)
                popBalloons.append(popBalloon)
                balloonPoppedFlags.append(false)
                popBalloon.isHidden = true
            }
        }

        num2Balloon?.isHidden = true
        nextButton?.isHidden = true
        nextLabel?.isHidden = true
        background?.zPosition = -1
        border?.zPosition = -1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            // Handle balloon taps
            for (index, balloon) in balloons.enumerated() {
                if node == balloon {
                    handleBalloonTapped(index: index)
                    return
                }
            }
            
            // Handle navigation button tap
            if node == nextButton || node == nextLabel {
                navigateToNumber3()
            }
        }
    }
    
    func handleBalloonTapped(index: Int) {
        guard index < balloons.count else { return }
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloons[index].isHidden = true
        popBalloons[index].isHidden = false
        balloonPoppedFlags[index] = true
        checkCompletion()
    }
    
    func checkCompletion() {
        if balloonPoppedFlags.allSatisfy({ $0 }) {
            run(SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false))
            num2Balloon?.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.nextButton?.isHidden = false
                self?.nextLabel?.isHidden = false
                self?.nextButton?.zPosition = 1
                self?.nextLabel?.zPosition = 2
            }
        }
    }
    
    func navigateToNumber3() {
        guard let context = modelContext else {
            print("Error: ModelContext is nil. Cannot navigate to Number3.")
            return
        }
        
        completeCurrentClass()
        
        if let number3Scene = SKScene(fileNamed: "Number3") as? Number2 {
            number3Scene.modelContext = context
            number3Scene.levelID = levelID
            number3Scene.partID = partID
            number3Scene.classID = nextClassID
            number3Scene.nextClassID = nextClassID + 1
            number3Scene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(number3Scene, transition: transition)
        } else {
            print("Error: Could not load Number3.sks.")
        }
    }
    
    func completeCurrentClass() {
        guard let context = modelContext else {
            print("Error: ModelContext is nil. Cannot complete the current class.")
            return
        }
        
        let fetchRequest = FetchDescriptor<GameProgress>(predicate: #Predicate { $0.levelID == levelID && $0.partID == partID && $0.classID == classID })
        
        do {
            if let currentClass = try context.fetch(fetchRequest).first {
                currentClass.isCompleted = true
                
                let nextClassRequest = FetchDescriptor<GameProgress>(predicate: #Predicate { $0.levelID == levelID && $0.partID == partID && $0.classID == nextClassID })
                if let nextClass = try context.fetch(nextClassRequest).first {
                    nextClass.isUnlocked = true
                }
                
                try context.save()
            } else {
                print("Error: Current class not found in GameProgress.")
            }
        } catch {
            print("Error completing current class: \(error.localizedDescription)")
        }
    }
}
