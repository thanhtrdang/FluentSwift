//
//  UIKit+ViewShadow.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/27/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

// MARK: Public API -

extension UIView {
  @discardableResult
  public func shadow(color: UIColor?, radius: CGFloat, opacity: CGFloat, offset: CGPoint) -> Self {
    shadowCommonSetup()

    shadowColor(layer: layer, color: color)
    shadowRadius(layer: layer, radius: radius)
    shadowOpacity(layer: layer, opacity: opacity)
    shadowOffset(layer: layer, offset: offset)

    return self
  }

  @discardableResult
  public func maskShadow(color: UIColor?, radius: CGFloat, opacity: CGFloat, offset: CGPoint) -> Self {
    // if a `layer.mask` is specified, add a new shadow layer to display the shadow to match the mask shape.
    if let mask = layer.mask as? CAShapeLayer {
      shadowCommonSetup()

      // Clear default layer borders
      layer.shadowColor = nil
      layer.shadowRadius = 0
      layer.shadowOpacity = 0

      // Remove any previous shadow layer
      layer.superlayer?.sublayers?
        .filter { $0.name == "shadowLayer-\(Unmanaged.passUnretained(self))" }
        .forEach { $0.removeFromSuperlayer() }

      // Create new layer with object's memory reference to make this string unique.
      // Otherwise common name will remove all the shadow layers as it's adding in layer's superview.
      let shadowLayer = CAShapeLayer()
      shadowLayer.name = "shadowLayer-\(Unmanaged.passUnretained(self))"
      shadowLayer.frame = frame

      shadowColor(layer: shadowLayer, color: color)
      shadowRadius(layer: shadowLayer, radius: radius)
      shadowOpacity(layer: shadowLayer, opacity: opacity)
      shadowOffset(layer: shadowLayer, offset: offset)
      shadowLayer.shadowPath = mask.path

      // Add to layer's superview in order to render shadow otherwise it will clip out due to mask layer.
      layer.superlayer?.insertSublayer(shadowLayer, below: layer)
    }

    return self
  }
}

// MARK: - Private API -

extension UIView {
  fileprivate func shadowColor(layer: CALayer, color: UIColor?) {
    if let color = color {
      layer.shadowColor = color.cgColor
    }
  }

  fileprivate func shadowRadius(layer: CALayer, radius: CGFloat) {
    if !radius.isNaN && radius > 0 {
      layer.shadowRadius = radius
    }
  }

  fileprivate func shadowOpacity(layer: CALayer, opacity: CGFloat) {
    if !opacity.isNaN && opacity >= 0 && opacity <= 1 {
      layer.shadowOpacity = Float(opacity)
    }
  }

  fileprivate func shadowOffset(layer: CALayer, offset: CGPoint) {
    if !offset.x.isNaN {
      layer.shadowOffset.width = offset.x
    }

    if !offset.y.isNaN {
      layer.shadowOffset.height = offset.y
    }
  }

  fileprivate func shadowCommonSetup() {
    // Need to set `layer.masksToBounds` to `false`.
    // If `layer.masksToBounds == true` then shadow doesn't work any more.
    if layer.masksToBounds {
      layer.masksToBounds = false
    }
  }
}
