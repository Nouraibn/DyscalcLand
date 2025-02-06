import SpriteKit

class BaseScene: SKScene {
    
    override func didMove(to view: SKView) {
        adjustSceneSize(for: view)
    }

    func adjustSceneSize(for view: SKView) {
        let targetSize = CGSize(width: 1180, height: 820) // الأبعاد الأصلية للمشهد
        let screenSize = view.bounds.size
        let isPortrait = screenSize.height > screenSize.width // التحقق من الاتجاه

        let scale = isPortrait ? min(screenSize.width / targetSize.width, screenSize.height / targetSize.height) : 1.0

        // ضبط حجم المشهد بحيث يظهر بالكامل بدون قص
        self.size = targetSize
        self.setScale(scale)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        self.scaleMode = .aspectFit // التأكد من عدم قص أي جزء من المشهد
    }
}
