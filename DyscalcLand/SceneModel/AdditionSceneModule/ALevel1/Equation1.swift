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
        background2 = self.childNode(withName: "background2") as? SKSpriteNode
        
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0)
        
        playSound(named: "ACountCotton")
        
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
        let sound = SKAction.playSoundFileNamed("\(soundName).mp3", waitForCompletion: false)
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
            
            let waitAction = SKAction.wait(forDuration: 1.0)
            let showButtonAction = SKAction.run {
                self.showNextButton()
            }
            let sequence = SKAction.sequence([waitAction, showButtonAction])
            self.run(sequence)
        } else {
           
            mainText.text = "Try Again!"
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
