//
//  UIKit+ViewCorner.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/27/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

// MARK: Public API -

extension UIView {
  @discardableResult
  public func corner(radius: CGFloat = 2, sides: CornerSides = .all) -> Self {
    if !radius.isNaN && radius > 0 {
      if sides == .all {
        layer.cornerRadius = radius
      } else {
        layer.cornerRadius = 0.0

        // if a layer mask is specified, remove it
        layer.mask?.removeFromSuperlayer()

        layer.mask = cornerSidesLayer(radius: radius, sides: sides)
      }
    }

    return self
  }
}

// MARK: - Helpers -

fileprivate enum CornerSide {
  case topLeft
  case topRight
  case bottomLeft
  case bottomRight
}

public struct CornerSides: OptionSet {
  public let rawValue: Int

  public static let unknown = CornerSides(rawValue: 0)
  public static let topLeft = CornerSides(rawValue: 1)
  public static let topRight = CornerSides(rawValue: 1 << 1)
  public static let bottomLeft = CornerSides(rawValue: 1 << 2)
  public static let bottomRight = CornerSides(rawValue: 1 << 3)
  public static let all: CornerSides = [.topLeft, .topRight, .bottomLeft, .bottomRight]

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

  fileprivate init(side: CornerSide?) {
    guard let side = side else {
      self = .unknown
      return
    }

    switch side {
    case .topLeft: self = .topLeft
    case .topRight: self = .topRight
    case .bottomLeft: self = .bottomLeft
    case .bottomRight: self = .bottomRight
    }
  }
}

// public extension CornerDesignable where Self: UICollectionViewCell {
//    public func configureCornerRadius() {
//        if !cornerRadius.isNaN && cornerRadius > 0 {
//
//            // Remove any previous corner mask, i.e. coming from UIView type implementation
//            if layer.mask?.name == "cornerSideLayer" {
//                layer.mask?.removeFromSuperlayer()
//            }
//            layer.cornerRadius = 0.0
//
//            if cornerSides == .allSides {
//                contentView.layer.cornerRadius = cornerRadius
//            } else {
//                contentView.layer.cornerRadius = 0.0
//
//                // if a layer mask is specified, remove it
//                contentView.layer.mask?.removeFromSuperlayer()
//
//                contentView.layer.mask = cornerSidesLayer()
//            }
//
//            contentView.layer.masksToBounds = true
//        } else {
//            contentView.layer.masksToBounds = false
//        }
//    }
// }

// MARK: - Private API -

extension UIView {
  fileprivate func cornerSidesLayer(radius: CGFloat, sides: CornerSides) -> CAShapeLayer {
    let cornerSideLayer = CAShapeLayer()
    cornerSideLayer.name = "cornerSideLayer"
    cornerSideLayer.frame = CGRect(origin: .zero, size: bounds.size)

    let cornerRadii = CGSize(width: radius, height: radius)

    var roundingCorners: UIRectCorner = []
    if sides.contains(.topLeft) {
      roundingCorners.insert(.topLeft)
    }
    if sides.contains(.topRight) {
      roundingCorners.insert(.topRight)
    }
    if sides.contains(.bottomLeft) {
      roundingCorners.insert(.bottomLeft)
    }
    if sides.contains(.bottomRight) {
      roundingCorners.insert(.bottomRight)
    }

    cornerSideLayer.path = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: roundingCorners,
                                        cornerRadii: cornerRadii).cgPath

    return cornerSideLayer
  }
}
