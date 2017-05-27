//
//  UIKit+View.swift
//  HomeLand-Prototype
//
//  Created by Thanh Dang on 5/16/17.
//  Copyright © 2017 Uta Apps. All rights reserved.
//

import UIKit

//MARK: - Button -
public extension UIButton {
    @discardableResult
    public func text(_ t: String) -> Self {
        setTitle(t, for: UIControlState())
        return self
    }
    
    /**
     Shortcut for `text = NSLocalizedString("X", comment: "")`
     */
    @discardableResult
    public func text(byKey key: String) -> Self {
        text(NSLocalizedString(key, comment: ""))
        return self
    }
    
    @discardableResult
    public func image(_ name: String) -> Self {
        setImage(UIImage(named:name), for: UIControlState())
        return self
    }
}

//MARK: - TextField -
public extension UITextField {
    @discardableResult
    public func placeholder(_ text: String) -> Self {
        placeholder = text
        return self
    }
}

//MARK: - Label -
public extension UILabel {
    @discardableResult
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    /**
        Shortcut for `text = NSLocalizedString("X", comment: "")`
     */
    @discardableResult
    public func text(byKey key: String) -> Self {
        text(NSLocalizedString(key, comment: ""))
        return self
    }
}

//MARK: - Image -
extension UIImage {
    static let empty = UIImage()
}

extension UIImageView {
    @discardableResult
    public func image(_ name: String) -> Self {
        image = UIImage(named: name)
        return self
    }
}
