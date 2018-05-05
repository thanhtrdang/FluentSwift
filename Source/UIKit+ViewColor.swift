//
//  UIKit+ViewFillColor.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/27/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

// MARK: Fill -

extension UIView {
  @discardableResult
  public func fill(color: UIColor, opacity: CGFloat = 1) -> Self {
    configBackground(color: color)
    configOpacity(opacity: opacity)

    return self
  }

  fileprivate func configBackground(color: UIColor) {
    backgroundColor = color
  }

  fileprivate func configOpacity(opacity: CGFloat) {
    if !opacity.isNaN && opacity >= 0 && opacity <= 1 {
      alpha = opacity
      isOpaque = (opacity == 1)
    }
  }
}

// MARK: - Tint -

extension UIView {
  /*
   tintOpacity (White): 0 to 1
   shadeOpacity (Black): 0 to 1
   toneOpacity (Black): 0 to 1

   *Note: Should be called in layoutSubviews
   */

  @discardableResult
  public func tint(tintOpacity: CGFloat, shadeOpacity: CGFloat, toneColor: UIColor?, toneOpacity: CGFloat) -> Self {
    if !tintOpacity.isNaN && tintOpacity >= 0 && tintOpacity <= 1 {
      addColorSubview(color: .white, opacity: tintOpacity)
    }

    if !shadeOpacity.isNaN && shadeOpacity >= 0 && shadeOpacity <= 1 {
      addColorSubview(color: .black, opacity: shadeOpacity)
    }

    if let toneColor = toneColor {
      if !toneOpacity.isNaN && toneOpacity >= 0 && toneOpacity <= 1 {
        addColorSubview(color: toneColor, opacity: toneOpacity)
      }
    }

    return self
  }

  fileprivate func addColorSubview(color: UIColor, opacity: CGFloat) {
    let subview = UIView(frame: bounds)
    subview.backgroundColor = color
    subview.alpha = opacity
    if layer.cornerRadius > 0 {
      subview.layer.cornerRadius = layer.cornerRadius
    }
    subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    insertSubview(subview, at: 0)
  }
}
