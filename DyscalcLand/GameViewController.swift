import UIKit
import SpriteKit
import GameplayKit
import SwiftData

class GameViewController: UIViewController {
    
    private var dataContainer: ModelContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataContainer()
        setupScene()
    }
   
    private func setupDataContainer() {
        do {
            dataContainer = try ModelContainer(for: MainLevel.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    private func setupScene() {
        if let view = self.view as? SKView {
            // تحميل المشهد الافتراضي "SplashScreen"
            if let scene = SKScene(fileNamed: "SplashScreen") as? BaseScene {
                scene.adjustSceneSize(for: view) // ضبط الحجم والتكبير تلقائيًا
                
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    // تحديث حجم المشهد عند تدوير الجهاز
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            if let skView = self.view as? SKView, let scene = skView.scene as? BaseScene {
                scene.adjustSceneSize(for: skView) // ضبط الحجم عند تغيير الاتجاه
            }
        }, completion: nil)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all // دعم جميع الاتجاهات
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
