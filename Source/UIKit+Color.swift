//
//  UIKit+Style.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/25/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

// MARK: Ref -

// Dynamic: https://github.com/yannickl/DynamicColor
// From Image: https://github.com/jathu/UIImageColors
// Night mode: https://github.com/Draveness/NightNight
// Random: https://github.com/onevcat/RandomColorSwift
// Predefined: https://github.com/bennyguitar/Colours
// Gradient:

// Full? https://github.com/ViccAlexander/Chameleon

// Xcode: https://github.com/omz/ColorSense-for-Xcode
// Mac app: https://github.com/oscardelben/Color-Picker-Pro
// http://www.jessesquires.com/swift-namespaced-constants/
// https://medium.com/@gurdeep060289/color-image-new-literals-in-the-cocoa-town-7ef4f2710194

// MARK: - convenience init -

extension UIColor {
  /*
   e.g #525760
   */
  public convenience init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt32()
    Scanner(string: hex).scanHexInt32(&int)
    // swiftlint:disable identifier_name
    let a, r, g, b: UInt32
    switch hex.count {
    case 3:
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6:
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8:
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (1, 1, 1, 0)
    }

    self.init(
      red: CGFloat(r) / 255,
      green: CGFloat(g) / 255,
      blue: CGFloat(b) / 255,
      alpha: CGFloat(a) / 255
    )
  }

  /**
   https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/UIColor%2BHex.swift
   https://github.com/tbaranes/SwiftyUtils/blob/master/Sources/Extensions/ColorExtension.swift
   Convenience initializer for

   - parameter rgb: UInt value in hex of the color. For example, 0xFF0000 or 0x00FFFF

   - returns: an UIColor with the specified hex value
   */
  public convenience init(rgb: UInt, alpha: CGFloat = 1.0) {
    self.init(
      red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgb & 0x0000FF) / 255.0,
      alpha: alpha
    )
  }

  public static let grey80 = UIColor(hex: "#525760")
  public static let grey60 = UIColor(hex: "#EDEDED")
  public static let grey40 = UIColor(hex: "#EDEDED")
  public static let grey20 = UIColor(hex: "#F9F9F9")
}

// MARK: - Components -
// swiftlint:disable identifier_name
extension UIColor {
  public var r: Int {
    var red: CGFloat = 0
    getRed(&red, green: nil, blue: nil, alpha: nil)
    return Int(red * 255)
  }

  public var g: Int {
    var green: CGFloat = 0
    getRed(nil, green: &green, blue: nil, alpha: nil)
    return Int(green * 255)
  }

  public var b: Int {
    var blue: CGFloat = 0
    getRed(nil, green: nil, blue: &blue, alpha: nil)
    return Int(blue * 255)
  }

  public var alpha: CGFloat {
    var alpha: CGFloat = 0
    getRed(nil, green: nil, blue: nil, alpha: &alpha)
    return alpha
  }
}

// MARK: - Brightness -

extension UIColor {
  public func lighten(_ amount: CGFloat = 0.25) -> UIColor {
    return hueColor(brightnessAmount: 1 + amount)
  }

  public func darken(_ amount: CGFloat = 0.25) -> UIColor {
    return hueColor(brightnessAmount: 1 - amount)
  }

  fileprivate func hueColor(brightnessAmount: CGFloat) -> UIColor {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0

    if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
      return UIColor(hue: hue, saturation: saturation, brightness: brightness * brightnessAmount, alpha: alpha)
    }

    return self
  }
}
