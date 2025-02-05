import SpriteKit

class Equation2: BaseScene {

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
    var handPositions: CGPoint!
    var isPressing: Bool = false
    var handMoveAction: SKAction?
    var cartLabel: SKLabelNode!

    var currentNumberIndex = 0
    var currentCottonCandyCount = 0
    var correctAnswer: Int = 0
    var answers: [Int] = []

    var mainLevel: Int = 2
    var subLevel: Int = 4
    let gameProgress = GameProgress.shared
    let equationManager = EquationManager()

    override func didMove(to view: SKView) {
        border = self.childNode(withName: "border") as? SKSpriteNode
        cottonCandyCart = self.childNode(withName: "CottonCandyCart") as? SKSpriteNode
        nextButton = self.childNode(withName: "NextButton") as? SKSpriteNode
        nextButtonLabel = self.childNode(withName: "NextLabel") as? SKLabelNode
        mainText = childNode(withName: "MainText") as? SKLabelNode
        mainEquation = self.childNode(withName: "Equation2") as? SKLabelNode
        background2 = self.childNode(withName: "background2") as? SKSpriteNode
        cartLabel = childNode(withName: "CartLabel") as? SKLabelNode
        
        if let guidingLabel = mainText {
            guidingLabel.fontName = "ComicSansMS-Bold"
            guidingLabel.text = "Let’s count how many cotton \n      candies there are!"
            guidingLabel.fontSize = 27
            
            // Enable line breaks by setting the max width for the label
            guidingLabel.horizontalAlignmentMode = .center
            guidingLabel.verticalAlignmentMode = .center

            // Set the maximum width for the label (ensures line breaks occur)
            guidingLabel.preferredMaxLayoutWidth = 500 // Adjust based on your scene's layout

            // Set the number of lines to 0 for multiline support
            guidingLabel.numberOfLines = 0
        }

           if let nextLabel = nextButtonLabel {
               nextLabel.fontName = "ComicSansMS-Bold"
               nextLabel.text = "Done"
               nextLabel.fontSize = 30
           }
           
        if let cart = cartLabel {
            cart.fontName = "ComicSansMS-Bold"
            cart.text = "Cotton Candy"
        }

        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0)

        let sound = SKAction.playSoundFileNamed("ENcountCotton.wav", waitForCompletion: false)
        self.run(sound)

        for i in 1..<5 {
            if let cottonCandy = self.childNode(withName: "PinkCottonCandy\(i)") as? SKSpriteNode {
                cottonCandies.append(cottonCandy)
                cottonCandy.zPosition = 1
            }
            if let numLabel = self.childNode(withName: "Num\(i)") as? SKLabelNode {
                numberCottonCandy.append(numLabel)
                numLabel.isHidden = true
                numLabel.zPosition = 2
                numLabel.text = "\(i)"
              //  numLabel.text = convertToArabicNumerals(i)
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

        if let firstCottonCandy = cottonCandies.first {
            handPress(cottonCandy: firstCottonCandy)
        }

      
        cottonCandyCart.zPosition = 0
        background2?.zPosition = -1
        mainEquation.zPosition = 4
        mainText.zPosition = 4
        border.zPosition = 3
        nextButtonLabel?.zPosition = 4
        cartLabel.zPosition = 10

        nextButton.isHidden = true
        nextButtonLabel.isHidden = true

        

    

        setEquation(mainLevel: mainLevel, subLevel: subLevel)
    }

  /*  func setEquation(mainLevel: Int, subLevel: Int) {
        if let equation1 = equationManager.getEquation(for: mainLevel, subLevel: subLevel) {
            mainEquation.text = String(equation1.equation.map { char in
                if let digit = char.wholeNumberValue {
                    return Character(UnicodeScalar(0x0660 + digit)!)
                } else {
                    return char
                }
            })

            correctAnswer = equation1.answer
        } else {
            mainEquation.text = "خطأ"
        }
    }*/
    func setEquation(mainLevel: Int, subLevel: Int) {
        if let equation1 = equationManager.getEquation(for: mainLevel, subLevel: subLevel) {
            mainEquation?.text = String(equation1.equation) // No digit conversion here
            correctAnswer = equation1.answer
        } else {
            mainEquation?.text = "خطأ"
        }
    }

    func handPress(cottonCandy: SKSpriteNode) {
        isPressing = true
        let cottonPressAction = SKAction.scale(to: 1.1, duration: 0.1)
        let cottonRevertAction = SKAction.scale(to: 1, duration: 0.1)
        let cottonSequence = SKAction.sequence([cottonPressAction, cottonRevertAction])
        cottonCandy.run(cottonSequence)
    }

    func showNumbers() {
        if currentCottonCandyCount < numberCottonCandy.count {
            let numText = numberCottonCandy[currentCottonCandyCount]
            numText.isHidden = false
            currentCottonCandyCount += 1

            let soundFileName = "E\(currentCottonCandyCount).mp4"
            let soundAction = SKAction.playSoundFileNamed(soundFileName, waitForCompletion: false)
            self.run(soundAction)

            if currentCottonCandyCount == cottonCandies.count {
                showMCQs(correctAnswer: currentCottonCandyCount)
                mainText.text = "Select the correct answer"           
                let delay1 = SKAction.wait(forDuration: 1.0)
                let playSound1 = SKAction.playSoundFileNamed("Select.wav", waitForCompletion: false)
                let delayedAction = SKAction.sequence([delay1, playSound1])
                self.run(delayedAction)
            }
        }
    }

    func showMCQs(correctAnswer: Int) {
        answers = [correctAnswer, correctAnswer + 1, correctAnswer - 1].shuffled()
        for (index, MCQ) in MCQs.enumerated() {
            MCQ.isHidden = false
            MCQLabels[index].text = "\(answers[index])"
            //MCQLabels[index].text = convertToArabicNumerals(answers[index])
            MCQLabels[index].isHidden = false
        }
    }

    func checkAnswer(_ selectedAnswer: Int) {
        if selectedAnswer == correctAnswer {
            mainText.text = "Excellent!"
            mainEquation.text = "\(mainEquation.text ?? "")\(correctAnswer)!"
            run(SKAction.playSoundFileNamed("ENExellent.wav", waitForCompletion: false))
            run(SKAction.playSoundFileNamed("correctAnswer.wav", waitForCompletion: false))

            let waitAction = SKAction.wait(forDuration: 3.0)
            let showButtonAction = SKAction.run {
                self.showNextButton()
            }
            let sequence = SKAction.sequence([waitAction, showButtonAction])
            self.run(sequence)
        } else {
            mainText.text = "Try again!"
            run(SKAction.playSoundFileNamed("wrongAnswer.wav", waitForCompletion: false))
            run(SKAction.playSoundFileNamed("ENTryagain.wav", waitForCompletion: false))
        }
    }

    func showNextButton() {
        nextButton.isHidden = false
        nextButtonLabel.isHidden = false
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
        showNumbers()
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
                if MCQ.contains(touchLocation), let answerText = MCQLabels[index].text, let selectedAnswer = arabicToEnglishNumeral(answerText) {
                    checkAnswer(selectedAnswer)
                }
            }
        }
    }

    func goToEScreen() {
        GameProgress.shared.saveProgress(for: 3, subLevel: 1)
        
        ClownMap.Equation5 = true  // Set the flag to true

        let nextScene = SKScene(fileNamed: "ClownMap")
        if let nextScene = nextScene {
            nextScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 0.1)
            self.view?.presentScene(nextScene, transition: transition)
        }
    }

    func convertToArabicNumerals(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar")
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }

    func arabicToEnglishNumeral(_ arabicNumeral: String) -> Int? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar")
        return formatter.number(from: arabicNumeral)?.intValue
    }

    func startOscillatingAnimation(for node: SKNode?, fromLeftOffset offset: CGFloat, duration: TimeInterval = 3.0) {
        guard let node = node else { return }

        let originalPosition = node.position

        let moveLeft = SKAction.moveBy(x: -offset, y: 0, duration: duration)
        let moveRight = SKAction.move(to: originalPosition, duration: duration)
        let pause = SKAction.wait(forDuration: 1.0)

        let scaleDown = SKAction.scale(to: 0.8, duration: 0.6)
        let scaleUp = SKAction.scale(to: 1.0, duration: 0.6)
        let pulse = SKAction.sequence([scaleDown, scaleUp])
        let oscillate = SKAction.sequence([pulse, moveLeft, moveRight, pause, pulse])
        let repeatOscillation = SKAction.repeatForever(oscillate)

        node.run(repeatOscillation)
    }

    func stopAndDisappear(for node: SKNode?) {
        guard let node = node else { return }

        node.removeAllActions()

        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([fadeOut, remove])
        node.run(sequence)
    }
}
