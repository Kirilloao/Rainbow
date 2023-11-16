//
//  UIButton-ext.swift
//  rainbow
//
//  Created by macbook on 12.11.2023.
//

import UIKit

extension UIButton {
    
    convenience init(title: String? = nil, backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = 0, image: String? = nil) {
        self.init(type: .system)
        self.frame = .infinite
        self.tintColor = .white
        
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
            let uiImage = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
            self.setImage(uiImage, for: .normal)
        }
    }
}
