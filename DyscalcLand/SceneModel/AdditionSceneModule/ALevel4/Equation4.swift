//import SpriteKit
//import GameplayKit
//
//class Equation4: SKScene {
//    var cottonCandies: [SKSpriteNode] = []
//    var numberCottonCandy: [SKLabelNode] = []
//    var background2: SKSpriteNode!
//    var HeadText: SKSpriteNode!
//    var CartLabel: SKSpriteNode!
//    var cottonCandyCart: SKSpriteNode!
//    var mainEquation: SKLabelNode!
//    var Result: SKLabelNode! // Ensure this is not force unwrapped
//    
//    var currentNumberIndex = 0 // Tracks which cotton candy is selected
//    
//    override func didMove(to view: SKView) {
//        
//        // Set the background color programmatically
//        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
//        
//        // Load nodes
//        HeadText = self.childNode(withName: "HeadText") as? SKSpriteNode
//        CartLabel = self.childNode(withName: "Background2") as? SKSpriteNode
//        background2 = self.childNode(withName: "Background2") as? SKSpriteNode
//        cottonCandyCart = self.childNode(withName: "CottonCandyCart") as? SKSpriteNode
//        mainEquation = self.childNode(withName: "Equation") as? SKLabelNode
//        
//        // Safely unwrap the Result label
//        if let resultNode = self.childNode(withName: "Result") as? SKLabelNode {
//            Result = resultNode
//        } else {
//            print("Error: 'Result' node not found in the scene.")
//        }
//        
//        // Ensure that HeadText, CartLabel, and mainEquation are not hidden and stay fixed in place
//        HeadText?.isHidden = false
//        CartLabel?.isHidden = false
//        mainEquation?.isHidden = false
//        Result?.isHidden = false
//        
//        // Place the background behind everything
//        background2?.zPosition = -1
//        
//        // Load and setup cotton candy and number labels
//        for i in 1..<6 {
//            if let cottonCandy = self.childNode(withName: "PinkCottonCandy\(i)") as? SKSpriteNode {
//                cottonCandies.append(cottonCandy)
//                cottonCandy.zPosition = 1
//            }
//            if let numLabel = self.childNode(withName: "Num\(i)") as? SKLabelNode {
//                numberCottonCandy.append(numLabel)
//                numLabel.isHidden = true // Hide initially
//                numLabel.zPosition = 2
//                numLabel.text = "\(i)"
//            }
//        }
//        
//        // Set zPosition for cotton candy cart
//        cottonCandyCart?.zPosition = 0
//        
//        // Initialize main equation
//        mainEquation.text = "2 + 3 ="
//        Result.text = "0" // Initial equation value
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let touchLocation = touch.location(in: self)
//            
//            // Check if the touch is on any cotton candy
//            for (index, cottonCandy) in cottonCandies.enumerated() {
//                if cottonCandy.contains(touchLocation), currentNumberIndex < numberCottonCandy.count {
//                    // Show number label when cotton candy is tapped
//                    numberCottonCandy[index].isHidden = false
//                    
//                    // Update the equation with the tapped number
//                    let numText = numberCottonCandy[index].text ?? "?"
//                    if currentNumberIndex == 0 {
//                        Result.text = "\(numText)"
//                    } else {
//                        Result.text = "\(numText)"
//                    }
//                    
//                    // Increment the index to track the next cotton candy
//                    currentNumberIndex += 1
//                }
//            }
//        }
//    }
//}



import SpriteKit
import GameplayKit


class Equation4: SKScene {
    var cottonCandies: [SKSpriteNode] = []
    var numberCottonCandy: [SKLabelNode] = []
    var cottonCandyCart: SKSpriteNode!
    var mainEquation: SKLabelNode!
        var background2: SKSpriteNode!

    
    var currentNumberIndex = 0 // to see which cotton candy is preseed
    
    override func didMove(to view: SKView) {
        
        cottonCandyCart = self.childNode(withName: "CottonCandyCart") as? SKSpriteNode
               mainEquation = self.childNode(withName: "Equation4") as? SKLabelNode
                background2 = self.childNode(withName: "background2") as? SKSpriteNode
                self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        background2.zPosition = -1

        playSound()
        for i in 1..<6 {
            
            if let cottonCandy = self.childNode(withName: "PinkCottonCandy\(i)") as? SKSpriteNode {
                cottonCandies.append(cottonCandy)
                cottonCandy.zPosition = 1
                print("CottonCandy\(i)")
            }
            if let numLabel = self.childNode(withName: "Num\(i)") as? SKLabelNode {
                numberCottonCandy.append(numLabel)
                numLabel.isHidden = true //hide the label so it dosent show the word Label
                numLabel.zPosition = 2
                numLabel.text = "\(i)"
                print("Num label \(i)")
            }
        }
        cottonCandyCart.zPosition = 0
                background2?.zPosition = -1
        mainEquation.zPosition = 4

        mainEquation.text = "2 + 3 = ?" // initial
    }
    func playSound(){
        let sound = SKAction.playSoundFileNamed("A count cotton.mp3", waitForCompletion: false)
        self.run(sound)
    }
    func updateEquation() {
        let baseEquation = "2 + 3 = "
        
        if currentNumberIndex < numberCottonCandy.count {
            let numText = numberCottonCandy[currentNumberIndex - 1].text ?? "?"
            mainEquation.text = "\(baseEquation)\(numText)?"
        } else {
            let resultText = numberCottonCandy.last?.text ?? "?"
            mainEquation.text = "\(baseEquation)\(resultText)!"

        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            //see if the touch was on the cotton candy
            for (index, cottonCandy) in cottonCandies.enumerated() {
                            if cottonCandy.contains(touchLocation) {
                                
                                if currentNumberIndex < numberCottonCandy.count {
                                    let numText = numberCottonCandy[index]
                                    
                                    numText.isHidden = false
                                                           
                                                          
                                                           currentNumberIndex += 1
                                    let soundFileName = "A\(index + 1).mp3" // Index starts from 0, so add 1
                                                        playSound(named: soundFileName)
                                                           
                                                
                                                           updateEquation()
                                    
//                                    if currentNumberIndex == numberCottonCandy.count {
//                                        mainText.text = "You got it!"
//                                    }
                               
                    }
                    
                }
            }
        }
    }
    func playSound(named soundName: String) {
        let sound = SKAction.playSoundFileNamed(soundName, waitForCompletion: false)
        self.run(sound)
    }
}
