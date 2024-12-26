import SpriteKit
import SwiftData

class Number3: SKScene {
    
    // Nodes from the .sks file
    var background: SKSpriteNode!
    var num3Balloon: SKSpriteNode!
    var balloon1: SKSpriteNode!
    var balloon2: SKSpriteNode!
    var balloon3: SKSpriteNode!
    var border: SKSpriteNode!
    var popBalloon1: SKSpriteNode!
    var popBalloon2: SKSpriteNode!
    var popBalloon3: SKSpriteNode!
    var guidingLabel: SKLabelNode!
    var equalLabel: SKLabelNode!
    var nextButton: SKSpriteNode!
    var nextLabel: SKLabelNode!
    
    // Flags to track progress
    var isBalloon1Popped = false
    var isBalloon2Popped = false
    var isBalloon3Popped = false
    
    var modelContext: ModelContext? // Reference to SwiftData model context
    
    override func didMove(to view: SKView) {
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0

        // Initialize nodes from the .sks file
        background = self.childNode(withName: "Background") as? SKSpriteNode
        num3Balloon = self.childNode(withName: "Num3Balloon") as? SKSpriteNode
        balloon1 = self.childNode(withName: "Balloon1") as? SKSpriteNode
        balloon2 = self.childNode(withName: "Balloon2") as? SKSpriteNode
        balloon3 = self.childNode(withName: "Balloon3") as? SKSpriteNode
        border = self.childNode(withName: "Border") as? SKSpriteNode
        popBalloon1 = self.childNode(withName: "PopBalloon1") as? SKSpriteNode
        popBalloon2 = self.childNode(withName: "PopBalloon2") as? SKSpriteNode
        popBalloon3 = self.childNode(withName: "PopBalloon3") as? SKSpriteNode
        guidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
        equalLabel = self.childNode(withName: "Equal") as? SKLabelNode
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        nextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode
        
        background?.zPosition = -1
        border?.zPosition = -1
        
        // Initial state: hide unnecessary elements
        popBalloon1?.isHidden = true
        popBalloon2?.isHidden = true
        popBalloon3?.isHidden = true
        num3Balloon?.isHidden = true
        nextButton?.isHidden = true
        nextLabel?.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node == balloon1 {
                handleBalloon1Tapped()
            } else if node == balloon2 {
                handleBalloon2Tapped()
            } else if node == balloon3 {
                handleBalloon3Tapped()
            } else if node == nextButton || node == nextLabel {
                navigateToNumber4()
            }
        }
    }
    
    func handleBalloon1Tapped() {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon1?.isHidden = true
        popBalloon1?.isHidden = false
        isBalloon1Popped = true
        checkCompletion()
    }
    
    func handleBalloon2Tapped() {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon2?.isHidden = true
        popBalloon2?.isHidden = false
        isBalloon2Popped = true
        checkCompletion()
    }
    
    func handleBalloon3Tapped() {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon3?.isHidden = true
        popBalloon3?.isHidden = false
        isBalloon3Popped = true
        checkCompletion()
    }
    
    func checkCompletion() {
        if isBalloon1Popped && isBalloon2Popped && isBalloon3Popped {
            run(SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false))
            num3Balloon?.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.nextButton?.isHidden = false
                self?.nextLabel?.isHidden = false
                self?.nextButton?.zPosition = 1
                self?.nextLabel?.zPosition = 2
            }
        }
    }
    
    func navigateToNumber4() {
        guard let context = modelContext else {
            print("Error: ModelContext is nil. Cannot navigate to Number4.")
            return
        }
        
        completeCurrentClass()
        
        if let number4Scene = SKScene(fileNamed: "Number4") as? Number4 {
            number4Scene.modelContext = context
            number4Scene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(number4Scene, transition: transition)
        } else {
            print("Error: Could not load Number4.sks.")
        }
    }
    
    func completeCurrentClass() {
        guard let context = modelContext else {
            print("Error: ModelContext is nil. Cannot complete the current class.")
            return
        }
        
        let fetchRequest = FetchDescriptor<GameProgress>(predicate: #Predicate { $0.levelID == 1 && $0.partID == 1 && $0.classID == 3 })
        
        do {
            if let currentClass = try context.fetch(fetchRequest).first {
                currentClass.isCompleted = true
                
                let nextClassRequest = FetchDescriptor<GameProgress>(predicate: #Predicate { $0.levelID == 1 && $0.partID == 1 && $0.classID == 4 })
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
