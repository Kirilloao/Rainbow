//
//  UIImage-ext.swift
//  rainbow
//
//  Created by macbook on 12.11.2023.
//

import UIKit

extension UIImageView {
    convenience init(clipToBounds: Bool? = true, image: String? = nil) {
        self.init(frame: .infinite)
        self.clipsToBounds = true
        if let image = image {
            self.image = UIImage(named: image)
        }
    }
}
