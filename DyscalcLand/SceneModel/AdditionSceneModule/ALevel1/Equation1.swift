import SpriteKit

class Equation1: SKScene {
    
    
    var cottonCandies: [SKSpriteNode] = []
    var numberCottonCandy: [SKLabelNode] = []
    var MCQs: [SKSpriteNode] = []
    var MCQLabels: [SKLabelNode] = []
    
    var cottonCandyCart: SKSpriteNode!
    var mainEquation: SKLabelNode!
    var background2: SKSpriteNode!
    var mainText: SKLabelNode!
    var border: SKSpriteNode!
    var nextButton: SKSpriteNode!
    var nextButtonLabel: SKLabelNode!
    
    var hand: SKSpriteNode!
    var handPositions: CGPoint!
    var isPressing: Bool = false // to control whether i want the hand to move or not
    var handMoveAction: SKAction? // action that makes the hand loop back and forth
    
    
    var currentNumberIndex = 0 // Tracks which cotton candy is pressed
    var currentCottonCandyCount = 0 // Tracks the total number of clicked cotton candies
    var correctAnswer: Int = 0
    var answers: [Int] = [] // hold shuffled answers
    
    var mainLevel: Int = 2
    var subLevel: Int = 2
    let gameProgress = GameProgress.shared
    let equationManager = EquationManager()
    
    override func didMove(to view: SKView) {
        
        border = self.childNode(withName: "border") as? SKSpriteNode
        cottonCandyCart = self.childNode(withName: "CottonCandyCart") as? SKSpriteNode
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        nextButtonLabel = self.childNode(withName: "ButtonLabel") as? SKLabelNode
        mainText = childNode(withName: "MainText") as? SKLabelNode
        mainEquation = self.childNode(withName: "Equation1") as? SKLabelNode
        hand = childNode(withName: "Hand") as? SKSpriteNode
        background2 = self.childNode(withName: "background2") as? SKSpriteNode
        
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0)
        
        playSound(named: "CountCotton")
        
        for i in 1..<3 {
            if let cottonCandy = self.childNode(withName: "PinkCottonCandy\(i)") as? SKSpriteNode {
                cottonCandies.append(cottonCandy)
                cottonCandy.zPosition = 1
            }
            if let numLabel = self.childNode(withName: "Num\(i)") as? SKLabelNode {
                numberCottonCandy.append(numLabel)
                numLabel.isHidden = true
                numLabel.zPosition = 2
                numLabel.text = "\(i)"
            }
        }
        
        for i in 1..<4 {
            if let MCQ = self.childNode(withName: "MCQTicket\(i)") as? SKSpriteNode {
                MCQs.append(MCQ)
                MCQ.isHidden = true
                MCQ.zPosition = 2
            }
        }
        for i in 1..<4 {
            if let MCQLabel = self.childNode(withName: "C\(i)") as? SKLabelNode {
                MCQLabels.append(MCQLabel)
                MCQLabel.isHidden = true
                MCQLabel.zPosition = 3
            }
        }
        
        handPositions = hand.position
        hand.alpha = 1
        
        if let firstCottonCandy = cottonCandies.first {
            handPress(cottonCandy: firstCottonCandy)
        }
        
        hand.zPosition = 3
        cottonCandyCart.zPosition = 0
        background2?.zPosition = -1
        mainEquation.zPosition = 4
        mainText.zPosition = 4
        border.zPosition = 3
        
       
        nextButton.isHidden = true
        nextButtonLabel.isHidden = true
        
        showNextButton()
        
        mainText.text = "Let’s count how many cotton candies there are"
        
        setEquation(mainLevel: mainLevel, subLevel: subLevel)
    }
    
    func playSound(named soundName: String) {
        
        let currentLanguage = Locale.current.languageCode ?? "en"
        
        var localizedSoundName: String
        
        if currentLanguage.prefix(2) == "ar" {
            localizedSoundName = "AR\(soundName).mp3" // Use Arabic sound file
        } else {
            localizedSoundName = "EN\(soundName).wav" // Default to English sound file
        }
        
        let sound = SKAction.playSoundFileNamed("\(localizedSoundName).mp3", waitForCompletion: false)
            self.run(sound)
    }

        func setEquation(mainLevel: Int, subLevel: Int) {
                if let equation1 = equationManager.getEquation(for: mainLevel, subLevel: subLevel) {
                    // Update the equation text and correct answer
                    mainEquation.text = "\(equation1.equation) ?"
                    correctAnswer = equation1.answer
                    
                    showMCQs(correctAnswer: correctAnswer)
                } else {
            mainEquation.text = "Error"
        }
    }
    func handPress(cottonCandy: SKSpriteNode) {
        isPressing = true
        
        hand.alpha = 0.5
        
        let cottonCandyPosition = cottonCandy.position //store the cotton candy i want to be pressed in a var
        
        //animation for the hand to move to the cotton candy
        let moveAction = SKAction.move(to: cottonCandyPosition, duration: 1)
        let scaleAction = SKAction.scale(to: 0.9, duration: 0.2)
        
        //animate the hand back (so the hand can go back and forth)
        let revertMoveAction = SKAction.move(to: cottonCandyPosition, duration: 0.2)
        let revertScaleAction = SKAction.scale(to: 1, duration: 0.2)
        
        let revertTransperncey = SKAction.fadeAlpha(to: 1, duration: 0.2)
        
        let pressSequaence = SKAction.sequence([moveAction, scaleAction,revertTransperncey, revertMoveAction, revertScaleAction])// group all the actions
        
        handMoveAction = SKAction.repeatForever(pressSequaence) // make pressSequanece repeat
        hand.run(handMoveAction!)
        
        let cottonPressAction = SKAction.scale(to: 1.1, duration: 0.1)
        let cottonRevertAction = SKAction.scale(to: 1, duration: 0.1)
        
        let cottonSequence = SKAction.sequence([cottonPressAction, cottonRevertAction])
        
        cottonCandy.run(cottonSequence)
    //play sound??
        
//        self.isPressing = false
        
        
    }
    func stopHandPress() {
        hand.removeAllActions() // stop all the actions
        hand.alpha = 0 // hide the hand
    }
   
    func showNumbers() {
        if currentCottonCandyCount < numberCottonCandy.count {
            let numText = numberCottonCandy[currentCottonCandyCount]
            numText.isHidden = false
            currentCottonCandyCount += 1
            
           
            let soundFileName = "A\(currentCottonCandyCount)"
            playSound(named: soundFileName)
            
            
            if currentCottonCandyCount == cottonCandies.count {
                showMCQs(correctAnswer: currentCottonCandyCount)
            }
        }
    }
    
    func showMCQs(correctAnswer: Int) {
        answers = [correctAnswer, correctAnswer + 1, correctAnswer - 1].shuffled() // Shuffle the answers
        
        for (index, MCQ) in MCQs.enumerated() {
            MCQ.isHidden = false
            MCQLabels[index].text = "\(answers[index])"
            MCQLabels[index].isHidden = false
        }
    }
    
    func checkAnswer(_ selectedAnswer: Int) {
        // If the answer is correct, update the text and show the Next button
        if selectedAnswer == correctAnswer {
            mainText.text = "Correct! Well Done"
            mainEquation.text = "\(mainEquation.text ?? "")\(correctAnswer)!" // Show the correct answer in the equation
            playSound(named: "Exellent")
            let waitAction = SKAction.wait(forDuration: 1.0)
            let showButtonAction = SKAction.run {
                self.showNextButton()
            }
            let sequence = SKAction.sequence([waitAction, showButtonAction])
            self.run(sequence)
        } else {
           
            mainText.text = "Try Again!"
            playSound(named: "Tryagain")
            resetLevel()
        }
    }
    
    func resetLevel() {
        currentCottonCandyCount = 0
        for numLabel in numberCottonCandy {
            numLabel.isHidden = true
        }
        for MCQLabel in MCQLabels {
            MCQLabel.isHidden = true
        }
        for MCQ in MCQs {
            MCQ.isHidden = true
        }
        currentNumberIndex = 0
        showNumbers() // Restart the number showing process // not working
    }
    
    
    func showNextButton() {
        nextButton.isHidden = false
        nextButtonLabel.isHidden = false
    }
    
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let node = self.atPoint(touchLocation)
            
            if node == nextButton {
                goToEScreen()
            }
            
            
            for (_, cottonCandy) in cottonCandies.enumerated() {
                if cottonCandy.contains(touchLocation) {
                   
                    stopHandPress()
                    showNumbers()
                }
            }
            
            for (index, MCQ) in MCQs.enumerated() {
                if MCQ.contains(touchLocation), let answerText = MCQLabels[index].text, let selectedAnswer = Int(answerText) {
                    checkAnswer(selectedAnswer) // Check if the selected answer is correct
                }
            }
            
           
        }
        func goToEScreen() {
            GameProgress.shared.saveProgress(for: 2, subLevel: 2)
            
            let nextScene = SKScene(fileNamed: "DragAndDrop2")
            if let nextScene = nextScene {
                nextScene.scaleMode = .aspectFill
                let transition = SKTransition.fade(withDuration: 0.1)
                self.view?.presentScene(nextScene, transition: transition)
            }
        }
    }
}
