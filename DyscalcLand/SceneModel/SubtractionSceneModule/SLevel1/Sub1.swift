import SpriteKit

class Sub1: SKScene {
    
    var background: SKSpriteNode!
    var bourd: SKSpriteNode!
    var tiket1: SKSpriteNode!
    var tiket2: SKSpriteNode!
    var tiket3: SKSpriteNode!
    var tiketLablel1: SKLabelNode!
    var bourdLablel: SKLabelNode!
    var tiketLablel2: SKLabelNode!
    var tiketLablel3: SKLabelNode!
    var NextButton: SKSpriteNode!
    var NextLablel: SKLabelNode!
    var bowlingArray: [SKSpriteNode] = []
    var bowlingArrayLabel: [SKLabelNode] = []
    var counter: Int = 0 // عداد الضغطات
    var allBowlingPressed: Bool = false
    var hand: SKSpriteNode!
    var handPositions: CGPoint!
    var isPressing: Bool = false // to control whether i want the hand to move or not
    var handMoveAction: SKAction? // action that makes the hand loop back and forth
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        
        // Load nodes from the scene
        background = self.childNode(withName: "backgoound2") as? SKSpriteNode
        bourdLablel = childNode(withName: "bourdLablel") as? SKLabelNode
        bourd = self.childNode(withName: "border") as? SKSpriteNode
        tiket1 = self.childNode(withName: "tikket1") as? SKSpriteNode
        tiket2 = self.childNode(withName: "tikket2") as? SKSpriteNode
        tiket3 = self.childNode(withName: "tikket3") as? SKSpriteNode
        tiketLablel1 = self.childNode(withName: "TiketLablel1") as? SKLabelNode
        tiketLablel2 = self.childNode(withName: "TiketLablel2") as? SKLabelNode
        tiketLablel3 = self.childNode(withName: "TiketLablel3") as? SKLabelNode
        NextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        NextLablel = self.childNode(withName: "NextLabel") as? SKLabelNode
        hand = self.childNode(withName: "hand") as? SKSpriteNode

        // Prepare bowling nodes and labels
        for i in 1...7 {
            if let bowling = self.childNode(withName: "Bowling\(i)") as? SKSpriteNode {
                bowlingArray.append(bowling)
                bowling.zPosition = 1
            }
            if let bowlingLabel = self.childNode(withName: "LabelNode\(i)") as? SKLabelNode {
                bowlingArrayLabel.append(bowlingLabel)
                bowlingLabel.isHidden = true
                bowlingLabel.zPosition = 2
            }
        }

        // Initial setup
        bourdLablel?.text = "هيا لنحسب عدد قطع البولنق!"
        bourdLablel?.zPosition = 4
        NextButton?.zPosition = 4
        NextLablel?.zPosition = 5

        tiket1?.isHidden = true
        tiket2?.isHidden = true
        tiket3?.isHidden = true
        tiketLablel1?.isHidden = true
        tiketLablel2?.isHidden = true
        tiketLablel3?.isHidden = true
        NextButton?.isHidden = true
        NextLablel?.isHidden = true

        playSound(named: "ACountb.mp3")
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

    func showLabel(for index: Int) {
        guard index < bowlingArrayLabel.count else { return }
        let labelNode = bowlingArrayLabel[index]

        if labelNode.isHidden {
            counter += 1
            labelNode.text = convertToArabicNumerals(counter)
            labelNode.isHidden = false

            // Play sound for the current counter
            let soundFileName = "A\(counter).mp3"
            playSound(named: soundFileName)

            if counter == bowlingArray.count {
                allBowlingPressed = true
                bourdLablel?.text = "اختر الإجابة الصحيحة!"
                let delay1 = SKAction.wait(forDuration: 1.0)
                let playSound1 = SKAction.playSoundFileNamed("ARSelectCorrectAnswer.mp3", waitForCompletion: false)
                let delayedAction = SKAction.sequence([delay1, playSound1])
                self.run(delayedAction)
                showTickets()
            }
        }
    }

    func showTickets() {
        tiket1?.isHidden = false
        tiket2?.isHidden = false
        tiket3?.isHidden = false

        tiketLablel1?.isHidden = false
        tiketLablel1?.text = convertToArabicNumerals(5)
        tiketLablel1?.zPosition = 3

        tiketLablel2?.isHidden = false
        tiketLablel2?.text = convertToArabicNumerals(6)
        tiketLablel2?.zPosition = 3

        tiketLablel3?.isHidden = false
        tiketLablel3?.text = convertToArabicNumerals(7)
        tiketLablel3?.zPosition = 3
    }

    func checkAnswer(selectedAnswer: Int) {
        if selectedAnswer == 7 {
            bourdLablel?.text = "أحسنت!"
            playSound(named: "correctAnswer.wav")
            NextButton?.isHidden = false
            NextLablel?.isHidden = false
            addPulsingAnimation(to: NextButton)
            run(SKAction.playSoundFileNamed("ARExellent.mp3", waitForCompletion: false))
        } else {
            bourdLablel?.text = "حاول مرة أخرى!"
            playSound(named: "wrongAnswer.wav")
            run(SKAction.playSoundFileNamed("ARTryagain.mp3", waitForCompletion: false))

        }
    }

    func addPulsingAnimation(to node: SKNode) {
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.6)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.6)
        let pulse = SKAction.sequence([scaleUp, scaleDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        node.run(repeatPulse)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        for (index, bowling) in bowlingArray.enumerated() {
            if bowling.contains(location) {
                showLabel(for: index)
            }
        }

        if allBowlingPressed {
            if tiket1?.contains(location) == true {
                checkAnswer(selectedAnswer: 5)
            } else if tiket2?.contains(location) == true {
                checkAnswer(selectedAnswer: 6)
            } else if tiket3?.contains(location) == true {
                checkAnswer(selectedAnswer: 7)
            }
        }

        if NextButton?.contains(location) == true {
            navigate()
        }
    }

    func navigate() {
        if let nextScene = SKScene(fileNamed: "Sub2") {
            nextScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(nextScene, transition: transition)
        }
    }
}
