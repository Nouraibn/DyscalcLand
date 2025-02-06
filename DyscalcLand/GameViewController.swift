import UIKit
import SwiftData
import SpriteKit

class GameViewController: UIViewController {
    private var dataContainer: ModelContainer!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataContainer()
        setupScene(sceneName: "SplashScreen")
       
    }
   
    private func setupDataContainer() {
        do {
        dataContainer = try ModelContainer(for: MainLevel.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    

    func setupScene(sceneName: String) {
        if let view = self.view as? SKView {
            if let scene = SKScene(fileNamed: sceneName) as? BaseScene {
                scene.adjustSceneSize(for: view) // إعادة ضبط المشهد كل مرة يتم تحميله
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true // السماح بالتدوير عند الحاجة
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all // دعم جميع الاتجاهات
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            if let skView = self.view as? SKView, let scene = skView.scene as? BaseScene {
                scene.adjustSceneSize(for: skView) // إعادة ضبط الحجم عند تغيير الاتجاه
            }
        }, completion: nil)
    }
}
