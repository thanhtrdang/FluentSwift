//
//  UIKit-Extensions.swift
//  HomeLand-Prototype
//
//  Created by Thanh Dang on 5/16/17.
//  Copyright © 2017 Uta Apps. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    static let grey80 = UIColor(hexString: "#525760")
    static let grey60 = UIColor(hexString: "#EDEDED")
    static let grey40 = UIColor(hexString: "#EDEDED")
    static let grey20 = UIColor(hexString: "#F9F9F9")
}

extension UIFont {
    static let mega     = UIFont.systemFont(ofSize: 36.0)
    static let h1       = UIFont.systemFont(ofSize: 28.0)
    static let h1Medium = UIFont.systemFont(ofSize: 28.0, weight: UIFontWeightMedium)
    static let h2       = UIFont.systemFont(ofSize: 24.0)
    static let h2Medium = UIFont.systemFont(ofSize: 24.0, weight: UIFontWeightMedium)
    static let h3       = UIFont.systemFont(ofSize: 18.0)
    static let h3Medium = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
    static let h4       = UIFont.systemFont(ofSize: 16.0)
    static let h4Medium = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightMedium)
    static let h5       = UIFont.systemFont(ofSize: 14.0)
    static let h5Medium = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightMedium)
    static let h6       = UIFont.systemFont(ofSize: 12.0)
    static let h6Medium = UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightMedium)
}

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

extension UIImage {
    static let empty = UIImage()
}
