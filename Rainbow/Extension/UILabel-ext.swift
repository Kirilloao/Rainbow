//
//  UILabel-ext.swift
//  rainbow
//
//  Created by macbook on 12.11.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String? = nil, font: UIFont? = .systemFont(ofSize: 20)) {
        self.init(frame: .infinite)
        if let text = text {
            self.text = text
        }
        if let font = font {
            self.font = font
        }
        
        
        
    }
}
