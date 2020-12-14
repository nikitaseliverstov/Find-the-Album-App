//
//  UILabel + Extension.swift
//  Find the Album App
//
//  Created by Nikita Seliverstov on 15.12.2020.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont?, textColor: UIColor, textAlignment: NSTextAlignment) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}

