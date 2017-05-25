//
//  UIKit+View.swift
//  HomeLand-Prototype
//
//  Created by Thanh Dang on 5/16/17.
//  Copyright © 2017 Uta Apps. All rights reserved.
//

import UIKit

//MARK: - UIView -
extension UIView {
    func styleShadow() -> Self {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 5, height: 10)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        
        return self
    }
}

//MARK: CALayer

//MARK: - Image - 
extension UIImage {
    static let empty = UIImage()
}
