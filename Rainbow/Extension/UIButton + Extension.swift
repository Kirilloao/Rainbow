//
//  UIButton-ext.swift
//  rainbow
//
//  Created by macbook on 12.11.2023.
//

import UIKit

extension UIButton {
    
    convenience init(title: String? = nil, backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = 0, image: String? = nil) {
        self.init(frame: .infinite)
        
        if let title = title {
            self.setTitle(title, for: .normal)
        }
        
        if let color = backgroundColor {
            self.backgroundColor = color
        }
        
        if let radius = cornerRadius {
            self.layer.cornerRadius = radius
        }
        
        if let image = image {
            self.setImage(UIImage(named: image), for: .normal)
        }
    }
}
