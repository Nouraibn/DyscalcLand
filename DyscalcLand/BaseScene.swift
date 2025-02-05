import SpriteKit

class BaseScene: SKScene {
    
    override func didMove(to view: SKView) {
        adjustSceneSize(for: view)
    }

    func adjustSceneSize(for view: SKView) {
        let targetSize = CGSize(width: 1180, height: 820) // الأبعاد الثابتة للمشهد
        let screenSize = view.bounds.size

        // حساب نسبة العرض إلى الارتفاع
        let widthRatio = screenSize.width / targetSize.width
        let heightRatio = screenSize.height / targetSize.height
        let scale = min(widthRatio, heightRatio) // نحافظ على الأبعاد الأصلية دون قص أي جزء

        // ضبط الحجم النهائي للمشهد مع الحفاظ على الأبعاد الأصلية
        self.size = targetSize
        self.setScale(scale)
        
        // تأكد من أن المشهد يبقى في منتصف الشاشة دائمًا
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: targetSize.width / 2, y: targetSize.height / 2)
        
        // استخدم `aspectFit` لضمان عدم اقتصاص المشهد في أي وضع
        self.scaleMode = .aspectFit
    }
}
