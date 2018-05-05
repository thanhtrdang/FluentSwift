//
//  UIKit+Application.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/25/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import Foundation
import UIKit

// MARK: Application -

// https://github.com/CosmicMind/Material
// https://github.com/hyperoslo/Sugar
public struct Application {
  fileprivate static func getString(_ key: String) -> String {
    guard let infoDictionary = Bundle.main.infoDictionary,
      let value = infoDictionary[key] as? String
    else { return "" }

    return value
  }

  public static var name: String = {
    let displayName = Application.getString("CFBundleDisplayName")
    return !displayName.isEmpty ? displayName : Application.getString("CFBundleName")
  }()

  public static var version: String = {
    Application.getString("CFBundleShortVersionString")
  }()

  public static var build: String = {
    Application.getString("CFBundleVersion")
  }()

  public static var executable: String = {
    Application.getString("CFBundleExecutable")
  }()

  public static var bundle: String = {
    Application.getString("CFBundleIdentifier")
  }()

  public static var schemes: [String] = {
    guard let infoDictionary = Bundle.main.infoDictionary,
      let urlTypes = infoDictionary["CFBundleURLTypes"] as? [AnyObject],
      let urlType = urlTypes.first as? [String: AnyObject],
      let urlSchemes = urlType["CFBundleURLSchemes"] as? [String]
    else { return [] }

    return urlSchemes
  }()

  public static var mainScheme: String? = {
    schemes.first
  }()

  /// A reference to the main UIWindow.
  public static var keyWindow: UIWindow? = {
    UIApplication.shared.keyWindow
  }()

  /// A Boolean indicating if the device is in Landscape mode.
  public static var isLandscape: Bool {
    return UIApplication.shared.statusBarOrientation.isLandscape
  }

  /// A Boolean indicating if the device is in Portrait mode.
  public static var isPortrait: Bool {
    return !isLandscape
  }

  /// The current UIInterfaceOrientation value.
  public static var orientation: UIInterfaceOrientation {
    return UIApplication.shared.statusBarOrientation
  }

  /// Retrieves the device status bar style.
  public static var statusBarStyle: UIStatusBarStyle {
    get {
      return UIApplication.shared.statusBarStyle
    }
    set(value) {
      UIApplication.shared.statusBarStyle = value
    }
  }

  /// Retrieves the device status bar hidden state.
  public static var isStatusBarHidden: Bool {
    get {
      return UIApplication.shared.isStatusBarHidden
    }
    set(value) {
      UIApplication.shared.isStatusBarHidden = value
    }
  }

  /**
   A boolean that indicates based on iPhone rules if the
   status bar should be shown.
   */
  public static var shouldStatusBarBeHidden: Bool {
    return isLandscape && .phone == Device.userInterfaceIdiom
  }

  /// A reference to the user interface layout direction.
  public static var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
    return UIApplication.shared.userInterfaceLayoutDirection
  }
}
