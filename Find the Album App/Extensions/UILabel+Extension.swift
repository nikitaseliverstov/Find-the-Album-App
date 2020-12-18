import UIKit

extension UILabel {
    convenience init(text: String? = nil, font: UIFont?, textColor: UIColor, textAlignment: NSTextAlignment) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}
