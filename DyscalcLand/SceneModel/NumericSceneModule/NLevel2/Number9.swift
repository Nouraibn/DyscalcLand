import SpriteKit
import SwiftData

class Number9: SKScene {
    
    // Nodes from the .sks file
    var background: SKSpriteNode!
    var num9Balloon: SKSpriteNode!
    var balloon1: SKSpriteNode!
    var balloon2: SKSpriteNode!
    var balloon3: SKSpriteNode!
    var balloon4: SKSpriteNode!
    var balloon5: SKSpriteNode!
    var balloon6: SKSpriteNode!
    var balloon7: SKSpriteNode!
    var balloon8: SKSpriteNode!
    var balloon9: SKSpriteNode!
    var border: SKSpriteNode!
    var popBalloon1: SKSpriteNode!
    var popBalloon2: SKSpriteNode!
    var popBalloon3: SKSpriteNode!
    var popBalloon4: SKSpriteNode!
    var popBalloon5: SKSpriteNode!
    var popBalloon6: SKSpriteNode!
    var popBalloon7: SKSpriteNode!
    var popBalloon8: SKSpriteNode!
    var popBalloon9: SKSpriteNode!
    var guidingLabel: SKLabelNode!
    var equalLabel: SKLabelNode!
    var nextButton: SKSpriteNode!
    var nextLabel: SKLabelNode!
    
    // Flags to track progress
    var isBalloon1Popped = false
    var isBalloon2Popped = false
    var isBalloon3Popped = false
    var isBalloon4Popped = false
    var isBalloon5Popped = false
    var isBalloon6Popped = false
    var isBalloon7Popped = false
    var isBalloon8Popped = false
    var isBalloon9Popped = false
    
    var modelContext: ModelContext!
    
    override func didMove(to view: SKView) {
        
        // Set background color
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0)
        
        // Initialize nodes
        background = self.childNode(withName: "Background") as? SKSpriteNode
        num9Balloon = self.childNode(withName: "Num9Balloon") as? SKSpriteNode
        balloon1 = self.childNode(withName: "Balloon1") as? SKSpriteNode
        balloon2 = self.childNode(withName: "Balloon2") as? SKSpriteNode
        balloon3 = self.childNode(withName: "Balloon3") as? SKSpriteNode
        balloon4 = self.childNode(withName: "Balloon4") as? SKSpriteNode
        balloon5 = self.childNode(withName: "Balloon5") as? SKSpriteNode
        balloon6 = self.childNode(withName: "Balloon6") as? SKSpriteNode
        balloon7 = self.childNode(withName: "Balloon7") as? SKSpriteNode
        balloon8 = self.childNode(withName: "Balloon8") as? SKSpriteNode
        balloon9 = self.childNode(withName: "Balloon9") as? SKSpriteNode
        border = self.childNode(withName: "Border") as? SKSpriteNode
        popBalloon1 = self.childNode(withName: "PopBalloon1") as? SKSpriteNode
        popBalloon2 = self.childNode(withName: "PopBalloon2") as? SKSpriteNode
        popBalloon3 = self.childNode(withName: "PopBalloon3") as? SKSpriteNode
        popBalloon4 = self.childNode(withName: "PopBalloon4") as? SKSpriteNode
        popBalloon5 = self.childNode(withName: "PopBalloon5") as? SKSpriteNode
        popBalloon6 = self.childNode(withName: "PopBalloon6") as? SKSpriteNode
        popBalloon7 = self.childNode(withName: "PopBalloon7") as? SKSpriteNode
        popBalloon8 = self.childNode(withName: "PopBalloon8") as? SKSpriteNode
        popBalloon9 = self.childNode(withName: "PopBalloon9") as? SKSpriteNode
        guidingLabel = self.childNode(withName: "GuidingLabel") as? SKLabelNode
        equalLabel = self.childNode(withName: "Equal") as? SKLabelNode
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        nextLabel = self.childNode(withName: "NextLabel") as? SKLabelNode
        
        background?.zPosition = -1
        border?.zPosition = -1
        
        // Hide pop balloons, num9Balloon, nextButton, and nextLabel
        hideAllPopBalloons()
        num9Balloon.isHidden = true
        nextButton?.isHidden = true
        nextLabel?.isHidden = true
    }
    
    func hideAllPopBalloons() {
        popBalloon1.isHidden = true
        popBalloon2.isHidden = true
        popBalloon3.isHidden = true
        popBalloon4.isHidden = true
        popBalloon5.isHidden = true
        popBalloon6.isHidden = true
        popBalloon7.isHidden = true
        popBalloon8.isHidden = true
        popBalloon9.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node == balloon1 {
                handleBalloonTapped(balloon: balloon1, popBalloon: popBalloon1, flag: &isBalloon1Popped)
            } else if node == balloon2 {
                handleBalloonTapped(balloon: balloon2, popBalloon: popBalloon2, flag: &isBalloon2Popped)
            } else if node == balloon3 {
                handleBalloonTapped(balloon: balloon3, popBalloon: popBalloon3, flag: &isBalloon3Popped)
            } else if node == balloon4 {
                handleBalloonTapped(balloon: balloon4, popBalloon: popBalloon4, flag: &isBalloon4Popped)
            } else if node == balloon5 {
                handleBalloonTapped(balloon: balloon5, popBalloon: popBalloon5, flag: &isBalloon5Popped)
            } else if node == balloon6 {
                handleBalloonTapped(balloon: balloon6, popBalloon: popBalloon6, flag: &isBalloon6Popped)
            } else if node == balloon7 {
                handleBalloonTapped(balloon: balloon7, popBalloon: popBalloon7, flag: &isBalloon7Popped)
            } else if node == balloon8 {
                handleBalloonTapped(balloon: balloon8, popBalloon: popBalloon8, flag: &isBalloon8Popped)
            } else if node == balloon9 {
                handleBalloonTapped(balloon: balloon9, popBalloon: popBalloon9, flag: &isBalloon9Popped)
            } else if node == nextButton || node == nextLabel {
                navigateToNumber10()
            }
        }
    }
    
    func handleBalloonTapped(balloon: SKSpriteNode?, popBalloon: SKSpriteNode?, flag: inout Bool) {
        run(SKAction.playSoundFileNamed("PopBalloon.wav", waitForCompletion: false))
        balloon?.isHidden = true
        popBalloon?.isHidden = false
        flag = true
        checkCompletion()
    }
    
    func checkCompletion() {
        if isBalloon1Popped && isBalloon2Popped && isBalloon3Popped && isBalloon4Popped && isBalloon5Popped && isBalloon6Popped && isBalloon7Popped && isBalloon8Popped && isBalloon9Popped {
            run(SKAction.playSoundFileNamed("NumAppear.wav", waitForCompletion: false))
            num9Balloon.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.nextButton?.isHidden = false
                self?.nextLabel?.isHidden = false
                self?.nextButton?.zPosition = 1
                self?.nextLabel?.zPosition = 2
            }
        }
    }
    
    func navigateToNumber10() {
        completeCurrentClass()
        if let number10Scene = SKScene(fileNamed: "Number10") as? Number10 {
            number10Scene.modelContext = modelContext
            number10Scene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(number10Scene, transition: transition)
        }
    }
    
    func completeCurrentClass() {
        let fetchRequest = FetchDescriptor<GameProgress>(predicate: #Predicate { $0.levelID == 1 && $0.partID == 2 && $0.classID == 9 })
        if let currentClass = try? modelContext.fetch(fetchRequest).first {
            currentClass.isCompleted = true
            let nextClassRequest = FetchDescriptor<GameProgress>(predicate: #Predicate { $0.levelID == 1 && $0.partID == 2 && $0.classID == 10 })
            if let nextClass = try? modelContext.fetch(nextClassRequest).first {
                nextClass.isUnlocked = true
            }
            try? modelContext.save()
        }
    }
}
