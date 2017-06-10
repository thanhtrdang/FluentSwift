//
//  UIKit+Font.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/27/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

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

public enum FontSize: CGFloat {
    case mega = 36
    case h1 = 28
    case h2 = 24
    case h3 = 18
    case h4 = 16
    case h5 = 14
    case h6 = 12
    case min = 9
}

// MARK: - System font - 
extension UIFont {
    @available(iOS 7, *)
    public class func systemFont(ofSize size: FontSize, weight: FontWeight = .regular) -> UIFont {
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
            
            return UIFont.systemFont(ofSize: size.rawValue, weight: fontWeight)
        } else {
            let systemFontName: String
            switch weight {
            case .ultraLight:
                systemFontName = FontName.helveticaNeueUltraLightItalic.rawValue
            case .thin:
                systemFontName = FontName.helveticaNeueThin.rawValue
            case .light:
                systemFontName = FontName.helveticaNeueLight.rawValue
            case .regular:
                systemFontName = FontName.helveticaNeue.rawValue
            case .medium, .semibold:
                systemFontName = FontName.helveticaNeueMedium.rawValue
            case .bold, .heavy, .black:
                systemFontName = FontName.helveticaNeueBold.rawValue
            }
            
            return UIFont(name: systemFontName, size: size.rawValue)!
        }
    }
}

extension UIFont {
    public static let mega      = UIFont.systemFont(ofSize: .mega)
    public static let megaHeavy = UIFont.systemFont(ofSize: .mega, weight: .heavy)
    public static let h1        = UIFont.systemFont(ofSize: .h1)
    public static let h1Medium  = UIFont.systemFont(ofSize: .h1, weight: .medium)
    public static let h1Heavy   = UIFont.systemFont(ofSize: .h1, weight: .heavy)
    public static let h2        = UIFont.systemFont(ofSize: .h2)
    public static let h2Medium  = UIFont.systemFont(ofSize: .h2, weight: .medium)
    public static let h2Heavy   = UIFont.systemFont(ofSize: .h2, weight: .heavy)
    public static let h3        = UIFont.systemFont(ofSize: .h3)
    public static let h3Medium  = UIFont.systemFont(ofSize: .h3, weight: .medium)
    public static let h4        = UIFont.systemFont(ofSize: .h4)
    public static let h4Medium  = UIFont.systemFont(ofSize: .h4, weight: .medium)
    public static let h5        = UIFont.systemFont(ofSize: .h5)
    public static let h5Medium  = UIFont.systemFont(ofSize: .h5, weight: .medium)
    public static let h6        = UIFont.systemFont(ofSize: .h6)
    public static let h6Medium  = UIFont.systemFont(ofSize: .h6, weight: .medium)
    public static let min       = UIFont.systemFont(ofSize: .min)
}

// MARK: - UIFontComplete -
public enum FontName: String, FontRepresentable {
    
    // Font Family: Copperplate
    case copperplateLight = "Copperplate-Light"
    case copperplate = "Copperplate"
    case copperplateBold = "Copperplate-Bold"
    
    // Font Family: Kohinoor Telugu
    case kohinoorTeluguRegular = "KohinoorTelugu-Regular"
    case kohinoorTeluguMedium = "KohinoorTelugu-Medium"
    case kohinoorTeluguLight = "KohinoorTelugu-Light"
    
    // Font Family: Thonburi
    case thonburi = "Thonburi"
    case thonburiBold = "Thonburi-Bold"
    case thonburiLight = "Thonburi-Light"
    
    // Font Family: Courier New
    case courierNewPSBoldMT = "CourierNewPS-BoldMT"
    case courierNewPSItalicMT = "CourierNewPS-ItalicMT"
    case courierNewPSMT = "CourierNewPSMT"
    case courierNewPSBoldItalicMT = "CourierNewPS-BoldItalicMT"
    
    // Font Family: Gill Sans
    case gillSansItalic = "GillSans-Italic"
    case gillSansBold = "GillSans-Bold"
    case gillSansBoldItalic = "GillSans-BoldItalic"
    case gillSansLightItalic = "GillSans-LightItalic"
    case gillSans = "GillSans"
    case gillSansLight = "GillSans-Light"
    case gillSansSemiBold = "GillSans-SemiBold"
    case gillSansSemiBoldItalic = "GillSans-SemiBoldItalic"
    case gillSansUltraBold = "GillSans-UltraBold"
    
    // Font Family: Apple SD Gothic Neo
    case appleSDGothicNeoBold = "AppleSDGothicNeo-Bold"
    case appleSDGothicNeoUltraLight = "AppleSDGothicNeo-UltraLight"
    case appleSDGothicNeoThin = "AppleSDGothicNeo-Thin"
    case appleSDGothicNeoRegular = "AppleSDGothicNeo-Regular"
    case appleSDGothicNeoLight = "AppleSDGothicNeo-Light"
    case appleSDGothicNeoMedium = "AppleSDGothicNeo-Medium"
    case appleSDGothicNeoSemiBold = "AppleSDGothicNeo-SemiBold"
    
    // Font Family: Marker Felt
    case markerFeltThin = "MarkerFelt-Thin"
    case markerFeltWide = "MarkerFelt-Wide"
    
    // Font Family: Avenir Next Condensed
    case avenirNextCondensedBoldItalic = "AvenirNextCondensed-BoldItalic"
    case avenirNextCondensedHeavy = "AvenirNextCondensed-Heavy"
    case avenirNextCondensedMedium = "AvenirNextCondensed-Medium"
    case avenirNextCondensedRegular = "AvenirNextCondensed-Regular"
    case avenirNextCondensedHeavyItalic = "AvenirNextCondensed-HeavyItalic"
    case avenirNextCondensedMediumItalic = "AvenirNextCondensed-MediumItalic"
    case avenirNextCondensedItalic = "AvenirNextCondensed-Italic"
    case avenirNextCondensedUltraLightItalic = "AvenirNextCondensed-UltraLightItalic"
    case avenirNextCondensedUltraLight = "AvenirNextCondensed-UltraLight"
    case avenirNextCondensedDemiBold = "AvenirNextCondensed-DemiBold"
    case avenirNextCondensedBold = "AvenirNextCondensed-Bold"
    case avenirNextCondensedDemiBoldItalic = "AvenirNextCondensed-DemiBoldItalic"
    
    // Font Family: Tamil Sangam MN
    case tamilSangamMN = "TamilSangamMN"
    case tamilSangamMNBold = "TamilSangamMN-Bold"
    
    // Font Family: Helvetica Neue
    case helveticaNeueItalic = "HelveticaNeue-Italic"
    case helveticaNeueBold = "HelveticaNeue-Bold"
    case helveticaNeueUltraLight = "HelveticaNeue-UltraLight"
    case helveticaNeueCondensedBlack = "HelveticaNeue-CondensedBlack"
    case helveticaNeueBoldItalic = "HelveticaNeue-BoldItalic"
    case helveticaNeueCondensedBold = "HelveticaNeue-CondensedBold"
    case helveticaNeueMedium = "HelveticaNeue-Medium"
    case helveticaNeueLight = "HelveticaNeue-Light"
    case helveticaNeueThin = "HelveticaNeue-Thin"
    case helveticaNeueThinItalic = "HelveticaNeue-ThinItalic"
    case helveticaNeueLightItalic = "HelveticaNeue-LightItalic"
    case helveticaNeueUltraLightItalic = "HelveticaNeue-UltraLightItalic"
    case helveticaNeueMediumItalic = "HelveticaNeue-MediumItalic"
    case helveticaNeue = "HelveticaNeue"
    
    // Font Family: Gurmukhi MN
    case gurmukhiMNBold = "GurmukhiMN-Bold"
    case gurmukhiMN = "GurmukhiMN"
    
    // Font Family: Times New Roman
    case timesNewRomanPSMT = "TimesNewRomanPSMT"
    case timesNewRomanPSBoldItalicMT = "TimesNewRomanPS-BoldItalicMT"
    case timesNewRomanPSItalicMT = "TimesNewRomanPS-ItalicMT"
    case timesNewRomanPSBoldMT = "TimesNewRomanPS-BoldMT"
    
    // Font Family: Georgia
    case georgiaBoldItalic = "Georgia-BoldItalic"
    case georgia = "Georgia"
    case georgiaItalic = "Georgia-Italic"
    case georgiaBold = "Georgia-Bold"
    
    // Font Family: Apple Color Emoji
    case appleColorEmoji = "AppleColorEmoji"
    
    // Font Family: Arial Rounded MT Bold
    case arialRoundedMTBold = "ArialRoundedMTBold"
    
    // Font Family: Kailasa
    case kailasaBold = "Kailasa-Bold"
    case kailasa = "Kailasa"
    
    // Font Family: Kohinoor Devanagari
    case kohinoorDevanagariLight = "KohinoorDevanagari-Light"
    case kohinoorDevanagariRegular = "KohinoorDevanagari-Regular"
    case kohinoorDevanagariSemibold = "KohinoorDevanagari-Semibold"
    
    // Font Family: Kohinoor Bangla
    case kohinoorBanglaSemibold = "KohinoorBangla-Semibold"
    case kohinoorBanglaRegular = "KohinoorBangla-Regular"
    case kohinoorBanglaLight = "KohinoorBangla-Light"
    
    // Font Family: Chalkboard SE
    case chalkboardSEBold = "ChalkboardSE-Bold"
    case chalkboardSELight = "ChalkboardSE-Light"
    case chalkboardSERegular = "ChalkboardSE-Regular"
    
    // Font Family: Sinhala Sangam MN
    case sinhalaSangamMNBold = "SinhalaSangamMN-Bold"
    case sinhalaSangamMN = "SinhalaSangamMN"
    
    // Font Family: PingFang TC
    case pingFangTCMedium = "PingFangTC-Medium"
    case pingFangTCRegular = "PingFangTC-Regular"
    case pingFangTCLight = "PingFangTC-Light"
    case pingFangTCUltralight = "PingFangTC-Ultralight"
    case pingFangTCSemibold = "PingFangTC-Semibold"
    case pingFangTCThin = "PingFangTC-Thin"
    
    // Font Family: Gujarati Sangam MN
    case gujaratiSangamMNBold = "GujaratiSangamMN-Bold"
    case gujaratiSangamMN = "GujaratiSangamMN"
    
    // Font Family: Damascus
    case damascusLight = "DamascusLight"
    case damascusBold = "DamascusBold"
    case damascusSemiBold = "DamascusSemiBold"
    case damascusMedium = "DamascusMedium"
    case damascus = "Damascus"
    
    // Font Family: Noteworthy
    case noteworthyLight = "Noteworthy-Light"
    case noteworthyBold = "Noteworthy-Bold"
    
    // Font Family: Geeza Pro
    case geezaPro = "GeezaPro"
    case geezaProBold = "GeezaPro-Bold"
    
    // Font Family: Avenir
    case avenirMedium = "Avenir-Medium"
    case avenirHeavyOblique = "Avenir-HeavyOblique"
    case avenirBook = "Avenir-Book"
    case avenirLight = "Avenir-Light"
    case avenirRoman = "Avenir-Roman"
    case avenirBookOblique = "Avenir-BookOblique"
    case avenirMediumOblique = "Avenir-MediumOblique"
    case avenirBlack = "Avenir-Black"
    case avenirBlackOblique = "Avenir-BlackOblique"
    case avenirHeavy = "Avenir-Heavy"
    case avenirLightOblique = "Avenir-LightOblique"
    case avenirOblique = "Avenir-Oblique"
    
    // Font Family: Academy Engraved LET
    case academyEngravedLetPlain = "AcademyEngravedLetPlain"
    
    // Font Family: Mishafi
    case diwanMishafi = "DiwanMishafi"
    
    // Font Family: Futura
    case futuraCondensedMedium = "Futura-CondensedMedium"
    case futuraCondensedExtraBold = "Futura-CondensedExtraBold"
    case futuraMedium = "Futura-Medium"
    case futuraMediumItalic = "Futura-MediumItalic"
    case futuraBold = "Futura-Bold"
    
    // Font Family: Farah
    case farah = "Farah"
    
    // Font Family: Kannada Sangam MN
    case kannadaSangamMN = "KannadaSangamMN"
    case kannadaSangamMNBold = "KannadaSangamMN-Bold"
    
    // Font Family: Arial Hebrew
    case arialHebrewBold = "ArialHebrew-Bold"
    case arialHebrewLight = "ArialHebrew-Light"
    case arialHebrew = "ArialHebrew"
    
    // Font Family: Arial
    case arialMT = "ArialMT"
    case arialBoldItalicMT = "Arial-BoldItalicMT"
    case arialBoldMT = "Arial-BoldMT"
    case arialItalicMT = "Arial-ItalicMT"
    
    // Font Family: Party LET
    case partyLetPlain = "PartyLetPlain"
    
    // Font Family: Chalkduster
    case chalkduster = "Chalkduster"
    
    // Font Family: Hoefler Text
    case hoeflerTextItalic = "HoeflerText-Italic"
    case hoeflerTextRegular = "HoeflerText-Regular"
    case hoeflerTextBlack = "HoeflerText-Black"
    case hoeflerTextBlackItalic = "HoeflerText-BlackItalic"
    
    // Font Family: Optima
    case optimaRegular = "Optima-Regular"
    case optimaExtraBlack = "Optima-ExtraBlack"
    case optimaBoldItalic = "Optima-BoldItalic"
    case optimaItalic = "Optima-Italic"
    case optimaBold = "Optima-Bold"
    
    // Font Family: Palatino
    case palatinoBold = "Palatino-Bold"
    case palatinoRoman = "Palatino-Roman"
    case palatinoBoldItalic = "Palatino-BoldItalic"
    case palatinoItalic = "Palatino-Italic"
    
    // Font Family: Lao Sangam MN
    case laoSangamMN = "LaoSangamMN"
    
    // Font Family: Malayalam Sangam MN
    case malayalamSangamMNBold = "MalayalamSangamMN-Bold"
    case malayalamSangamMN = "MalayalamSangamMN"
    
    // Font Family: Al Nile
    case alNileBold = "AlNile-Bold"
    case alNile = "AlNile"
    
    // Font Family: Bradley Hand
    case bradleyHandITCTTBold = "BradleyHandITCTT-Bold"
    
    // Font Family: PingFang HK
    case pingFangHKUltralight = "PingFangHK-Ultralight"
    case pingFangHKSemibold = "PingFangHK-Semibold"
    case pingFangHKThin = "PingFangHK-Thin"
    case pingFangHKLight = "PingFangHK-Light"
    case pingFangHKRegular = "PingFangHK-Regular"
    case pingFangHKMedium = "PingFangHK-Medium"
    
    // Font Family: Trebuchet MS
    case trebuchetBoldItalic = "Trebuchet-BoldItalic"
    case trebuchetMS = "TrebuchetMS"
    case trebuchetMSBold = "TrebuchetMS-Bold"
    case trebuchetMSItalic = "TrebuchetMS-Italic"
    
    // Font Family: Helvetica
    case helveticaBold = "Helvetica-Bold"
    case helvetica = "Helvetica"
    case helveticaLightOblique = "Helvetica-LightOblique"
    case helveticaOblique = "Helvetica-Oblique"
    case helveticaBoldOblique = "Helvetica-BoldOblique"
    case helveticaLight = "Helvetica-Light"
    
    // Font Family: Courier
    case courierBoldOblique = "Courier-BoldOblique"
    case courier = "Courier"
    case courierBold = "Courier-Bold"
    case courierOblique = "Courier-Oblique"
    
    // Font Family: Cochin
    case cochinBold = "Cochin-Bold"
    case cochin = "Cochin"
    case cochinItalic = "Cochin-Italic"
    case cochinBoldItalic = "Cochin-BoldItalic"
    
    // Font Family: Hiragino Mincho ProN
    case hiraMinProNW6 = "HiraMinProN-W6"
    case hiraMinProNW3 = "HiraMinProN-W3"
    
    // Font Family: Devanagari Sangam MN
    case devanagariSangamMN = "DevanagariSangamMN"
    case devanagariSangamMNBold = "DevanagariSangamMN-Bold"
    
    // Font Family: Oriya Sangam MN
    case oriyaSangamMN = "OriyaSangamMN"
    case oriyaSangamMNBold = "OriyaSangamMN-Bold"
    
    // Font Family: Snell Roundhand
    case snellRoundhandBold = "SnellRoundhand-Bold"
    case snellRoundhand = "SnellRoundhand"
    case snellRoundhandBlack = "SnellRoundhand-Black"
    
    // Font Family: Zapf Dingbats
    case zapfDingbatsITC = "ZapfDingbatsITC"
    
    // Font Family: Bodoni 72
    case bodoniSvtyTwoITCTTBold = "BodoniSvtyTwoITCTT-Bold"
    case bodoniSvtyTwoITCTTBook = "BodoniSvtyTwoITCTT-Book"
    case bodoniSvtyTwoITCTTBookIta = "BodoniSvtyTwoITCTT-BookIta"
    
    // Font Family: Verdana
    case verdanaItalic = "Verdana-Italic"
    case verdanaBoldItalic = "Verdana-BoldItalic"
    case verdana = "Verdana"
    case verdanaBold = "Verdana-Bold"
    
    // Font Family: American Typewriter
    case americanTypewriterCondensedLight = "AmericanTypewriter-CondensedLight"
    case americanTypewriter = "AmericanTypewriter"
    case americanTypewriterCondensedBold = "AmericanTypewriter-CondensedBold"
    case americanTypewriterLight = "AmericanTypewriter-Light"
    case americanTypewriterSemibold = "AmericanTypewriter-Semibold"
    case americanTypewriterBold = "AmericanTypewriter-Bold"
    case americanTypewriterCondensed = "AmericanTypewriter-Condensed"
    
    // Font Family: Avenir Next
    case avenirNextUltraLight = "AvenirNext-UltraLight"
    case avenirNextUltraLightItalic = "AvenirNext-UltraLightItalic"
    case avenirNextBold = "AvenirNext-Bold"
    case avenirNextBoldItalic = "AvenirNext-BoldItalic"
    case avenirNextDemiBold = "AvenirNext-DemiBold"
    case avenirNextDemiBoldItalic = "AvenirNext-DemiBoldItalic"
    case avenirNextMedium = "AvenirNext-Medium"
    case avenirNextHeavyItalic = "AvenirNext-HeavyItalic"
    case avenirNextHeavy = "AvenirNext-Heavy"
    case avenirNextItalic = "AvenirNext-Italic"
    case avenirNextRegular = "AvenirNext-Regular"
    case avenirNextMediumItalic = "AvenirNext-MediumItalic"
    
    // Font Family: Baskerville
    case baskervilleItalic = "Baskerville-Italic"
    case baskervilleSemiBold = "Baskerville-SemiBold"
    case baskervilleBoldItalic = "Baskerville-BoldItalic"
    case baskervilleSemiBoldItalic = "Baskerville-SemiBoldItalic"
    case baskervilleBold = "Baskerville-Bold"
    case baskerville = "Baskerville"
    
    // Font Family: Khmer Sangam MN
    case khmerSangamMN = "KhmerSangamMN"
    
    // Font Family: Didot
    case didotItalic = "Didot-Italic"
    case didotBold = "Didot-Bold"
    case didot = "Didot"
    
    // Font Family: Savoye LET
    case savoyeLetPlain = "SavoyeLetPlain"
    
    // Font Family: Bodoni Ornaments
    case bodoniOrnamentsITCTT = "BodoniOrnamentsITCTT"
    
    // Font Family: Symbol
    case symbol = "Symbol"
    
    // Font Family: Menlo
    case menloItalic = "Menlo-Italic"
    case menloBold = "Menlo-Bold"
    case menloRegular = "Menlo-Regular"
    case menloBoldItalic = "Menlo-BoldItalic"
    
    // Font Family: Bodoni 72 Smallcaps
    case bodoniSvtyTwoSCITCTTBook = "BodoniSvtyTwoSCITCTT-Book"
    
    // Font Family: Papyrus
    case papyrus = "Papyrus"
    case papyrusCondensed = "Papyrus-Condensed"
    
    // Font Family: Hiragino Sans
    case hiraginoSansW3 = "HiraginoSans-W3"
    case hiraginoSansW6 = "HiraginoSans-W6"
    
    // Font Family: PingFang SC
    case pingFangSCUltralight = "PingFangSC-Ultralight"
    case pingFangSCRegular = "PingFangSC-Regular"
    case pingFangSCSemibold = "PingFangSC-Semibold"
    case pingFangSCThin = "PingFangSC-Thin"
    case pingFangSCLight = "PingFangSC-Light"
    case pingFangSCMedium = "PingFangSC-Medium"
    
    // Font Family: Myanmar Sangam MN
    case myanmarSangamMNBold = "MyanmarSangamMN-Bold"
    case myanmarSangamMN = "MyanmarSangamMN"
    
    // Font Family: Euphemia UCAS
    case euphemiaUCASItalic = "EuphemiaUCAS-Italic"
    case euphemiaUCAS = "EuphemiaUCAS"
    case euphemiaUCASBold = "EuphemiaUCAS-Bold"
    
    // Font Family: Zapfino
    case zapfino = "Zapfino"
    
    // Font Family: Bodoni 72 Oldstyle
    case bodoniSvtyTwoOSITCTTBook = "BodoniSvtyTwoOSITCTT-Book"
    case bodoniSvtyTwoOSITCTTBold = "BodoniSvtyTwoOSITCTT-Bold"
    case bodoniSvtyTwoOSITCTTBookIt = "BodoniSvtyTwoOSITCTT-BookIt"
}

public protocol FontRepresentable: RawRepresentable {}

extension FontRepresentable where Self.RawValue == String {
    /// An alternative way to get a particular `UIFont` instance from a `Font` value.
    ///
    /// - parameter of size: The desired size of the font.
    ///
    /// - returns a `UIFont` instance of the desired font family and size, or
    /// `nil` if the font family or size isn't installed.
    public func of(size: FontSize) -> UIFont? {
        return UIFont(name: rawValue, size: size.rawValue)
    }
}

extension UIFont {
    public convenience init?(font: FontName, size: FontSize) {
        self.init(name: font.rawValue, size: size.rawValue)
    }
}
