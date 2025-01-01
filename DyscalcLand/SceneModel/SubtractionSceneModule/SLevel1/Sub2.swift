import SpriteKit
import CoreMotion

class Sub2: SKScene {
    
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
    var didDropBowlingPins : Bool = false
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
        Next = self.childNode(withName: "Next") as? SKSpriteNode
        Nextlablel = self.childNode(withName: "Nextlablel") as? SKLabelNode
        bowlingBall = self.childNode(withName: "bowlingBall") as? SKSpriteNode
        // Initial setup
        bourdLablel?.text = "Touch Screan"
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
        addPulsingAnimation(to: bowlingBall)

    }
    func addPulsingAnimation(to node: SKNode) {
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.6) // Scale up
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.6) // Scale
        
        let pulse = SKAction.sequence([scaleUp, scaleDown]) // Create a
        
        let repeatPulse = SKAction.repeatForever (pulse) // Repeat the pu
        node.run(repeatPulse) // Apply the animation to the node
    }
    
    
    func playSound(named soundName: String) {
        let playAction = SKAction.playSoundFileNamed(soundName, waitForCompletion: false)
        self.run(playAction)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Device shook!") // للتحقق من استقبال الحدث
            playSound(named: "Bdrop.wav")
            dropBowlingPins()
        }
    }
    
    func dropBowlingPins() {
        guard !didDropBowlingPins else { return } // إذا تم إسقاط البولينج بالفعل، لا تفعل شيئًا
        didDropBowlingPins = true // تحديث الحالة لتجنب تشغيل الصوت مرة أخرى

        playSound(named: "Bdrop.wav") // تشغيل الصوت عند السقوط
        
        bowling1?.isHidden = true
        Bowling1Drop?.isHidden = false
        
        bowling2?.isHidden = true
        Bowling2Drop?.isHidden = false
        
        let delay = SKAction.wait(forDuration: 1.0)
        let showQuestionAndTicketsAction = SKAction.run { self.showQuestionAndTickets() }
        self.run(SKAction.sequence([delay, showQuestionAndTicketsAction]))
    }

        
    func showQuestionAndTickets() {
        bourdLablel?.text = "how many bowling pin standing "
        tiket1?.isHidden = false
        tiket2?.isHidden = false
        tiket3?.isHidden = false
        tiketLablel1?.isHidden = false
        tiketLablel2?.isHidden = false
        tiketLablel3?.isHidden = false
        Qustion?.isHidden = false
        Qustion.text = "7 - 2 = ?"
        
        tiketLablel1?.text = "5" // الإجابة الصحيحة
        tiketLablel2?.text = "6"
        tiketLablel3?.text = "7"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if bowlingBall.contains(location) {
              playSound(named: "Button.mp3") // تشغيل الصوت أثناء الضغط
          }
        if touch.tapCount == 2 {
           

            if bowlingBall.contains(location) { // استبدل "bowlingBall" بالاسم الفعلي للعنصر
                dropBowlingPins()// إسقاط الكرات عند الضغط مرتين
                bowlingBall?.isHidden = true
                return
            }

        }

        if tiket1?.contains(location) == true {
            playSound(named: "correctAnswer.wav") // صوت الإجابة الصحيحة
            Next?.isHidden = false
            Nextlablel?.text = "Next"
            Nextlablel?.zPosition = 10
            Nextlablel?.isHidden = false
            addPulsingAnimation(to: Next)
        } else if tiket2?.contains(location) == true || tiket3?.contains(location) == true  {
            playSound(named: "wrongAnswer.wav") // صوت الإجابة الخاطئة
        }
        
        //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        print("Screen tapped!") // للتحقق من استقبال اللمس
        //        playSound(named: "Bdrop 1.wav")
        //        dropBowlingPins()
        //    }
        
    }
    
}
