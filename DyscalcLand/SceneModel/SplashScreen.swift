import SpriteKit

class SplashScreen: BaseScene {
    
    var logo: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        // ضبط لون الخلفية برمجيًا
        self.backgroundColor = SKColor(red: 1.0, green: 0.984, blue: 0.941, alpha: 1.0) // Hex: #FFFBF0
        
        // تحميل العناصر الثابتة من المشهد
        logo = self.childNode(withName: "Logo") as? SKSpriteNode
        
        logo?.alpha = 0.0
        
        // تشغيل أنيميشن شعار البداية
        runSplashScreen()
    }
    
    private func runSplashScreen() {
        // تشغيل تأثير الظهور والاختفاء التدريجي
        logo.run(SKAction.sequence([
            SKAction.fadeIn(withDuration: 1.0), // الظهور خلال 1 ثانية
            SKAction.wait(forDuration: 1.5),   // انتظار 1.5 ثانية
            SKAction.fadeOut(withDuration: 1.0) // الاختفاء خلال 1 ثانية
        ])) { [weak self] in
            self?.navigateToWelcomeScreen()
        }
    }
    
    private func navigateToWelcomeScreen() {
        // إنشاء مشهد `WelcomeScreen` مع ضبط الحجم تلقائيًا
        if let welcomeScreen = WelcomeScreen(fileNamed: "WelcomeScreen") {
            welcomeScreen.scaleMode = .aspectFill
            welcomeScreen.adjustSceneSize(for: self.view!) // ضبط المشهد تلقائيًا بناءً على الاتجاه
            
            // إنشاء تأثير انتقال جديد باستخدام دوران + تلاشي
            let transition = SKTransition.crossFade(withDuration: 1.2)
            
            self.view?.presentScene(welcomeScreen, transition: transition)
        }
    }
}
