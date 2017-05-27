//
//  UIKit+Image.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/27/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

//MARK: - Image -
extension UIImage {
    static let empty = UIImage()
}

//MARK: - UIImageView -
extension UIImageView {
    @discardableResult
    public func image(_ name: String) -> Self {
        image = UIImage(named: name)
        return self
    }
}
