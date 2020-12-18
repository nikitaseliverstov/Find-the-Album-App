import UIKit

extension UIImageView {
    convenience init(contentMode: UIView.ContentMode, clipsToBounds: Bool, cornerRadius: CGFloat) {
        self.init()
        self.contentMode = contentMode
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = cornerRadius
    }
}
