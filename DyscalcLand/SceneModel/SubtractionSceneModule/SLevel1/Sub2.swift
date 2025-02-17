import SpriteKit
import CoreMotion

class Sub2: BaseScene {
    
    var background: SKSpriteNode!
    var bourd: SKSpriteNode!
    var bowling1: SKSpriteNode!
    var bowling2: SKSpriteNode!
    var bowling3: SKSpriteNode!
    var bowling4: SKSpriteNode!
    var bowling5: SKSpriteNode!
    var bowling6: SKSpriteNode!
    var bowling7: SKSpriteNode!
    var Next: SKSpriteNode!
    var tiket1: SKSpriteNode!
    var tiket2: SKSpriteNode!
    var tiket3: SKSpriteNode!
    var bourdLablel: SKLabelNode!
    var tiketLablel1: SKLabelNode!
    var tiketLablel2: SKLabelNode!
    var tiketLablel3: SKLabelNode!
    var Bowling1Drop: SKSpriteNode!
    var Bowling2Drop: SKSpriteNode!
    var Qustion: SKLabelNode!
    var motionManager: CMMotionManager!
    var Nextlablel: SKLabelNode!
    var bowlingBall: SKSpriteNode!
    var didDropBowlingPins: Bool = false
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        
        // Load nodes from the scene
        background = self.childNode(withName: "background") as? SKSpriteNode
        bourd = self.childNode(withName: "bourd") as? SKSpriteNode
        bourdLablel = self.childNode(withName: "bourdLablel") as? SKLabelNode
        bowling1 = self.childNode(withName: "Bowling1") as? SKSpriteNode
        bowling2 = self.childNode(withName: "Bowling2") as? SKSpriteNode
        bowling3 = self.childNode(withName: "Bowling3") as? SKSpriteNode
        bowling4 = self.childNode(withName: "Bowling4") as? SKSpriteNode
        bowling5 = self.childNode(withName: "Bowling5") as? SKSpriteNode
        bowling6 = self.childNode(withName: "Bowling6") as? SKSpriteNode
        bowling7 = self.childNode(withName: "Bowling7") as? SKSpriteNode
        Bowling1Drop = self.childNode(withName: "Bowling1Drop") as? SKSpriteNode
        Bowling2Drop = self.childNode(withName: "Bowling2Drop") as? SKSpriteNode
        tiket1 = self.childNode(withName: "tikket1") as? SKSpriteNode
        tiket2 = self.childNode(withName: "tikket2") as? SKSpriteNode
        tiket3 = self.childNode(withName: "tikket3") as? SKSpriteNode
        tiketLablel1 = self.childNode(withName: "TiketLablel1") as? SKLabelNode
        tiketLablel2 = self.childNode(withName: "TiketLablel2") as? SKLabelNode
        tiketLablel3 = self.childNode(withName: "TiketLablel3") as? SKLabelNode
        Qustion = self.childNode(withName: "Question") as? SKLabelNode
        Next = self.childNode(withName: "NextButton") as? SKSpriteNode
        Nextlablel = self.childNode(withName: "NextLabel") as? SKLabelNode
        bowlingBall = self.childNode(withName: "bowlingBall") as? SKSpriteNode
        
        if let guidingLabel = bourdLablel {
            guidingLabel.fontName = "ComicSansMS-Bold"
            guidingLabel.text = "Hit the pins with balling ball!"
            guidingLabel.fontSize = 28
            
            // Enable line breaks by setting the max width for the label
            guidingLabel.horizontalAlignmentMode = .center
            guidingLabel.verticalAlignmentMode = .center

            // Set the maximum width for the label (ensures line breaks occur)
            guidingLabel.preferredMaxLayoutWidth = 500 // Adjust based on your scene's layout

            // Set the number of lines to 0 for multiline support
            guidingLabel.numberOfLines = 0
        }

           if let nextLabel =  Nextlablel {
               nextLabel.fontName = "ComicSansMS-Bold"
               nextLabel.text = "Done"
               nextLabel.fontSize = 30
           }
           
        
        // Initial setup
       
        run(SKAction.playSoundFileNamed("Hit.mp4", waitForCompletion: false))
        bourdLablel?.isHidden = false
        
        Qustion?.isHidden = true
        Bowling1Drop?.isHidden = true
        Bowling2Drop?.isHidden = true
        tiket1?.isHidden = true
        tiket2?.isHidden = true
        tiket3?.isHidden = true
        tiketLablel1?.isHidden = true
        tiketLablel2?.isHidden = true
        tiketLablel3?.isHidden = true
        Next?.isHidden = true
        Nextlablel?.isHidden = true
        
        motionManager = CMMotionManager()
        
        background?.zPosition = -2
        bourd?.zPosition = -1
        bowlingBall?.zPosition = 2
        Nextlablel?.zPosition = 3
        Nextlablel?.zPosition = 2
        bourdLablel?.zPosition = 4
        addPulsingAnimation(to: bowlingBall)
    }
    
    func addPulsingAnimation(to node: SKNode) {
        let originalScale = node.xScale // Store the original scale of the node
        let scaleUp = SKAction.scale(to: originalScale * 1.2, duration: 0.6) // Scale up relative to the original size
        let scaleDown = SKAction.scale(to: originalScale, duration: 0.6) // Scale back to the original size
        let pulse = SKAction.sequence([scaleUp, scaleDown]) // Create the pulsing sequence
        let repeatPulse = SKAction.repeatForever(pulse) // Repeat the pulsing animation forever
        node.run(repeatPulse)
    }

    func playSound(named soundName: String) {
        let playAction = SKAction.playSoundFileNamed(soundName, waitForCompletion: false)
        self.run(playAction)
    }
    
    func convertToArabicNumerals(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar")
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            playSound(named: "Bdrop.wav")
            dropBowlingPins()
        }
    }
    
    func dropBowlingPins() {
        guard !didDropBowlingPins else { return }
        didDropBowlingPins = true
        
        playSound(named: "Bdrop.wav")
        
        bowling1?.isHidden = true
        Bowling1Drop?.isHidden = false
        bowling2?.isHidden = true
        Bowling2Drop?.isHidden = false
        bourdLablel?.alpha = 1.0
        
        let delay = SKAction.wait(forDuration: 1.0)
        let showQuestionAndTicketsAction = SKAction.run {
            self.bourdLablel.text = "Select the correct answer!"
            let delay1 = SKAction.wait(forDuration: 1.0)
            let playSound1 = SKAction.playSoundFileNamed("Select.wav", waitForCompletion: false)
            let delayedAction = SKAction.sequence([delay1, playSound1])
            self.run(delayedAction)
            self.showQuestionAndTickets()
        }
        self.run(SKAction.sequence([delay, showQuestionAndTicketsAction]))
    }
    
    func showQuestionAndTickets() {
        Qustion?.isHidden = false
        Qustion?.text = "7 - 2 = ?"
        Qustion.fontName = "ComicSansMS-Bold"
        
        tiket1?.isHidden = false
        tiket2?.isHidden = false
        tiket3?.isHidden = false
        
        tiketLablel1?.isHidden = false
        tiketLablel1?.text = "5"
        tiketLablel1.fontName = "ComicSansMS-Bold"
        tiketLablel1?.zPosition = 3
        

        tiketLablel2?.isHidden = false
        tiketLablel2?.text = "6"
        tiketLablel2.fontName = "ComicSansMS-Bold"
        tiketLablel2?.zPosition = 3
        
        tiketLablel3?.isHidden = false
        tiketLablel3?.text = "7"
        tiketLablel3.fontName = "ComicSansMS-Bold"
        tiketLablel3?.zPosition = 3
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if bowlingBall.contains(location) {
            playSound(named: "Button.mp3")
        }
        if touch.tapCount == 2 {
            if bowlingBall.contains(location) {
                dropBowlingPins()
                bowlingBall?.isHidden = true
                return
            }
        }
        
        if tiket1?.contains(location) == true {
            playSound(named: "correctAnswer.wav")
            run(SKAction.playSoundFileNamed("ENExellent.wav", waitForCompletion: false))
            bourdLablel?.text = "Excellent!"
            Next?.isHidden = false
            Nextlablel?.zPosition = 10
            Nextlablel?.isHidden = false
            addPulsingAnimation(to: Next)
        } else if tiket2?.contains(location) == true || tiket3?.contains(location) == true {
            playSound(named: "wrongAnswer.wav")
            bourdLablel?.text = "Try again!"
            run(SKAction.playSoundFileNamed("ENTryagain.wav", waitForCompletion: false))
        }
        
        if Next?.contains(location) == true {
            navigate()
        }
    }
    
    func navigate() {
        ClownMap.fromSub2 = true
        if let number2Scene = SKScene(fileNamed: "ClownMap") as? BaseScene{
            number2Scene.scaleMode = .aspectFill
            number2Scene.adjustSceneSize(for: self.view!)
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(number2Scene, transition: transition)}
    }
}
