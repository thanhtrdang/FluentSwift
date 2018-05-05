//
//  UIKit+Screen.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/25/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

// MARK: - Screen -

// https://github.com/CosmicMind/Material
public struct Screen {
  /// Retrieves the device bounds.
  public static var bounds: CGRect {
    return UIScreen.main.bounds
  }

  /// Retrieves the device width.
  public static var width: CGFloat {
    return bounds.width
  }

  /// Retrieves the device height.
  public static var height: CGFloat {
    return bounds.height
  }

  /// Retrieves the device scale.
  public static var scale: CGFloat = {
    UIScreen.main.scale
  }()
}
