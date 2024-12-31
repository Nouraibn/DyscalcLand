import SpriteKit

class Sub1: SKScene {
    
    var background: SKSpriteNode!
    var bourd: SKSpriteNode!
    var tiket1: SKSpriteNode!
    var tiket2: SKSpriteNode!
    var tiket3: SKSpriteNode!
    var tiketLablel1: SKLabelNode!
    var tiketLablel2: SKLabelNode!
    var tiketLablel3: SKLabelNode!
    var NextButton : SKSpriteNode!
    var NextLablel : SKLabelNode!
    var bowlingArray: [SKSpriteNode] = []
    var bowlingArrayLabel: [SKLabelNode] = []
    var counter: Int = 0 // عداد الضغطات
    var allBowlingPressed: Bool = false
    
    
    
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        
        // تحميل العقد من المشهد
        background = self.childNode(withName: "backgoound2") as? SKSpriteNode
        bourd = self.childNode(withName: "border") as? SKSpriteNode
        tiket1 = self.childNode(withName: "tikket1") as? SKSpriteNode
        tiket2 = self.childNode(withName: "tikket2") as? SKSpriteNode
        tiket3 = self.childNode(withName: "tikket3") as? SKSpriteNode
        tiketLablel1 = self.childNode(withName: "TiketLablel1") as? SKLabelNode
        tiketLablel2 = self.childNode(withName: "TiketLablel2") as? SKLabelNode
        tiketLablel3 = self.childNode(withName: "TiketLablel3") as? SKLabelNode
        NextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        NextLablel = self.childNode(withName: "NextLablel") as? SKLabelNode
        // إعداد كرات البولينج والليبلات المرتبطة بها
        for i in 1...7 {
            if let bowling = self.childNode(withName: "Bowling\(i)") as? SKSpriteNode {
                bowlingArray.append(bowling)
                bowling.zPosition = 1
            }
            if let bowlingLabel = self.childNode(withName: "LabelNode\(i)") as? SKLabelNode {
                bowlingArrayLabel.append(bowlingLabel)
                bowlingLabel.isHidden = true
                bowlingLabel.zPosition = 2
                
                background?.zPosition = -2
                       bourd?.zPosition = -1
                
                       
            }
        }
        
        // إخفاء التذاكر والليبلات
        tiket1?.isHidden = true
        tiket2?.isHidden = true
        tiket3?.isHidden = true
        tiketLablel1?.isHidden = true
        tiketLablel2?.isHidden = true
        tiketLablel3?.isHidden = true
        NextButton?.isHidden = true
        NextLablel?.isHidden = true
        
        let playClickSound = SKAction.playSoundFileNamed("Our-butten-click.wav", waitForCompletion: false)
          self.run(playClickSound)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        // التحقق من الكرات المضغوطة
        for (index, bowling) in bowlingArray.enumerated() {
            if bowling.contains(location) {
                showLabel(for: index)
                
            }
        }
        
        // التفاعل مع التيكتس
        if allBowlingPressed {
            if tiket1?.contains(location) == true {
                checkAnswer(selectedAnswer: 5)
            } else if tiket2?.contains(location) == true {
                checkAnswer(selectedAnswer: 6)
            } else if tiket3?.contains(location) == true {
                checkAnswer(selectedAnswer: 7)
            }
        }
    }
    
    func showLabel(for index: Int) {
        guard index < bowlingArrayLabel.count else { return }
        let labelNode = bowlingArrayLabel[index]
        let playClickSound = SKAction.playSoundFileNamed("Our-butten-click.wav", waitForCompletion: false)
          self.run(playClickSound)
          
        // إذا لم يتم كشف الليبل مسبقًا، قم بزيادة العداد وكشفه
        if labelNode.isHidden {
            counter += 1
            labelNode.text = "\(counter)"
            labelNode.isHidden = false
            
            // إذا تم الضغط على جميع كرات البولينج
            if counter == bowlingArray.count {
                allBowlingPressed = true
                showTickets()
            }
        }
    }
    
    func showTickets() {
        // عرض التيكتس والليبلات بعد الضغط على جميع الكرات
        tiket1?.isHidden = false
        tiket1.zPosition = 1

        tiket2?.isHidden = false
        tiket2.zPosition = 1

        
        tiket3?.isHidden = false
        tiket3.zPosition = 1

        if let tiketLablel1 = tiketLablel1 {
            tiketLablel1.isHidden = false
            tiketLablel1.text = "5"
            tiketLablel1.zPosition = 2
        }
        
        if let tiketLablel2 = tiketLablel2 {
            tiketLablel2.isHidden = false
            tiketLablel2.text = "6"
            tiketLablel2.zPosition = 2
        }
        
        if let tiketLablel3 = tiketLablel3 {
            tiketLablel3.isHidden = false
            tiketLablel3.text = "7"
            tiketLablel3.zPosition = 2
        }
    }
    
    func checkAnswer(selectedAnswer: Int) {
        if selectedAnswer == 7 {
            let playCorrectSound = SKAction.playSoundFileNamed("correctAnswer.wav", waitForCompletion: false)
                    self.run(playCorrectSound) // تشغيل صوت الإجابة الصحيحة
            NextButton?.isHidden = false
            NextLablel?.isHidden = false
            NextLablel.text = "Next"
            // يمكنك إضافة حركة أو تأثير لإظهار النجاح
        } else {
            let playCorrectSound = SKAction.playSoundFileNamed("wrongAnswer.wav", waitForCompletion: false)
                    self.run(playCorrectSound)
            // يمكنك إضافة تأثير لإظهار الخطأ
        }
    }
}
