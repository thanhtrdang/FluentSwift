//
//  UIKit+Style.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/25/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

//MARK: - Color -
//Dynamic: https://github.com/yannickl/DynamicColor
//From Image: https://github.com/jathu/UIImageColors
//Night mode: https://github.com/Draveness/NightNight
//Random: https://github.com/onevcat/RandomColorSwift
// Hex <-> Color
//Xcode: https://github.com/omz/ColorSense-for-Xcode
//Mac app: https://github.com/oscardelben/Color-Picker-Pro
//Predefined: https://github.com/bennyguitar/Colours
//Gradient:

//Full? https://github.com/ViccAlexander/Chameleon

extension UIColor {
    /*
     https://github.com/IBAnimatable/IBAnimatable
     
     e.g #525760
     */
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
     
     - returns: a UIColor with the specified hex value
     */
    public convenience init(rgb: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    public static let grey80 = UIColor(hexString: "#525760")
    public static let grey60 = UIColor(hexString: "#EDEDED")
    public static let grey40 = UIColor(hexString: "#EDEDED")
    public static let grey20 = UIColor(hexString: "#F9F9F9")
}

//MARK: - Font -
//https://www.uber.design
//https://github.com/Nirma/UIFontComplete
//Icon font:
//    https://github.com/PrideChung/FontAwesomeKit,
//    https://github.com/FortAwesome/Font-Awesome
//    https://github.com/alexdrone/ios-fontawesome
//    https://github.com/dzenbot/Iconic
//    https://github.com/Vaberer/Font-Awesome-Swift
//    https://github.com/ranesr/SwiftIcons

public enum FontWeight {
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
}

extension UIFont {
    @available(iOS 7, *)
    public class func systemFont(ofSize fontSize: CGFloat, weight: FontWeight) -> UIFont {
        if #available(iOS 8.2, *) {
            let fontWeight: CGFloat
            switch weight {
            case .ultraLight:
                fontWeight = UIFontWeightUltraLight
            case .thin:
                fontWeight = UIFontWeightThin
            case .light:
                fontWeight = UIFontWeightLight
            case .regular:
                fontWeight = UIFontWeightRegular
            case .medium:
                fontWeight = UIFontWeightMedium
            case .semibold:
                fontWeight = UIFontWeightSemibold
            case .bold:
                fontWeight = UIFontWeightBold
            case .heavy:
                fontWeight = UIFontWeightHeavy
            case .black:
                fontWeight = UIFontWeightBlack
            }
            
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        } else {
            let systemFontName: String
            switch weight {
            case .ultraLight:
                systemFontName = "HelveticaNeue-UltraLight"
            case .thin:
                systemFontName = "HelveticaNeue-Thin"
            case .light:
                systemFontName = "HelveticaNeue-Light"
            case .regular:
                systemFontName = "HelveticaNeue"
            case .medium, .semibold:
                systemFontName = "HelveticaNeue-Medium"
            case .bold, .heavy, .black:
                systemFontName = "HelveticaNeue-Bold"
            }
            
            return UIFont(name: systemFontName, size: fontSize)!
        }
    }
}

extension UIFont {
    public static let mega     = UIFont.systemFont(ofSize: 36.0)
    public static let h1       = UIFont.systemFont(ofSize: 28.0)
    public static let h1Medium = UIFont.systemFont(ofSize: 28.0, weight: .medium)
    public static let h2       = UIFont.systemFont(ofSize: 24.0)
    public static let h2Medium = UIFont.systemFont(ofSize: 24.0, weight: .medium)
    public static let h3       = UIFont.systemFont(ofSize: 18.0)
    public static let h3Medium = UIFont.systemFont(ofSize: 18.0, weight: .medium)
    public static let h4       = UIFont.systemFont(ofSize: 16.0)
    public static let h4Medium = UIFont.systemFont(ofSize: 16.0, weight: .medium)
    public static let h5       = UIFont.systemFont(ofSize: 14.0)
    public static let h5Medium = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    public static let h6       = UIFont.systemFont(ofSize: 12.0)
    public static let h6Medium = UIFont.systemFont(ofSize: 12.0, weight: .medium)
}
