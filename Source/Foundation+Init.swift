//
//  Foundation+Init.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/25/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import CoreGraphics
import Foundation

// MARK: NSObject -

// Use: e.g. UITableViewCell identifier..
// https://medium.cobeisfresh.com/accessing-types-from-extensions-in-swift-32ca87ec5190
extension NSObject {
  public var className: String {
    return type(of: self).className
  }

  public static var className: String {
    return String(describing: self)
  }
}

// MARK: - Then -

// https://github.com/devxoul/Then
public protocol Then {}

public extension Then where Self: Any {
  /// Makes it available to set properties with closures just after initializing.
  ///
  ///     let frame = CGRect().with {
  ///       $0.origin.x = 10
  ///       $0.size.width = 100
  ///     }
  public func with(_ block: (inout Self) -> Void) -> Self {
    var copy = self
    block(&copy)
    return copy
  }

  /// Makes it available to execute something with closures.
  ///
  ///     UserDefaults.standard.do {
  ///       $0.set("devxoul", forKey: "username")
  ///       $0.set("devxoul@gmail.com", forKey: "email")
  ///       $0.synchronize()
  ///     }
  public func `do`(_ block: (Self) -> Void) {
    block(self)
  }
}

public extension Then where Self: AnyObject {
  /// Makes it available to set properties with closures just after initializing.
  ///
  ///     let label = UILabel().then {
  ///       $0.textAlignment = .Center
  ///       $0.textColor = UIColor.blackColor()
  ///       $0.text = "Hello, World!"
  ///     }
  public func then(_ block: (Self) -> Void) -> Self {
    block(self)
    return self
  }
}

extension NSObject: Then {}
extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}
