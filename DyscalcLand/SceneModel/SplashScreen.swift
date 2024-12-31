import SpriteKit

class SplashScreen: SKScene {
    
    var logo: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        // Set the background color programmatically
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        
        // Load fixed nodes from the scene
        logo = self.childNode(withName: "Logo") as? SKSpriteNode
        
        
        logo?.alpha = 0.0
        
        // Add an animation or delay
        runSplashScreen()
    }
    
    private func runSplashScreen() {
        // Fade in the logo
        logo.run(SKAction.sequence([
            SKAction.fadeIn(withDuration: 1.0), // Fade in over 1 second
            SKAction.wait(forDuration: 1.5),   // Wait for 1.5 seconds
            SKAction.fadeOut(withDuration: 1.0) // Fade out over 1 second
        ])) { [weak self] in
            self?.navigateToWelcomeScreen()
        }
    }
    
    private func navigateToWelcomeScreen() {
        // Create an instance of the WelcomeScreen scene
        if let welcomeScreen = WelcomeScreen(fileNamed: "WelcomeScreen") {
            let transition = SKTransition.fade(withDuration: 1.0) // Smooth fade transition
            welcomeScreen.scaleMode = .aspectFill
            self.view?.presentScene(welcomeScreen, transition: transition)
        }
    }
}
