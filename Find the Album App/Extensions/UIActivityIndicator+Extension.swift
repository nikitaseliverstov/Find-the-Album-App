import UIKit

extension UIActivityIndicatorView {
    convenience init(color: UIColor, backgroundColor: UIColor? = nil) {
        self.init()
        self.color = color
        self.backgroundColor = backgroundColor
    }
}
