//
//  UIKit+Text.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/27/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

// https://github.com/lexrus/LTMorphingLabel (effect)
// https://github.com/tobihagemann/THLabel
// https://github.com/nicklockwood/FXLabel
// https://github.com/overboming/ZCAnimatedLabel
// https://github.com/zipme/RQShineLabel
// https://github.com/Yalantis/Preloader.Ophiuchus
// https://github.com/facebook/Shimmer

// https://github.com/optonaut/ActiveLabel.swift (tapable)

// https://github.com/mineschan/MZTimerLabel (timer, countdown)
// https://github.com/suzuki-0000/CountdownLabel

// https://github.com/TTTAttributedLabel/TTTAttributedLabel (attributed)

// https://github.com/me-abhinav/NumberMorphView (number, animation)

// TODO:
/*
 - link
 - color
 - font
 - underline, bold, italic
 - stroke???
 */

// https://github.com/marmelroy/Format

// https://github.com/Ekhoo/Translucid
// https://github.com/Raizlabs/BonMot

// https://github.com/kazuhiro4949/StringStylizer
// https://github.com/eddiekaiger/SwiftyAttributes
// https://github.com/malcommac/SwiftRichString
// https://github.com/evermeer/AttributedTextView
// https://github.com/dimpiax/StyleDecorator

// https://github.com/delba/TextAttributes
// https://github.com/Nirma/Attributed
// https://github.com/zats/Tribute

// MARK: - TextAttributes

public enum LigatureStyle: Int {
  case none
  case `default`
  case all
}

public enum VerticalGlyphForm: Int {
  case horizontal
  case vertical
}

public enum TextEffect {
  case letterpress

  init?(name: String) {
    if name == NSAttributedString.TextEffectStyle.letterpressStyle.rawValue {
      self = .letterpress
    } else {
      return nil
    }
  }

  var name: String {
    switch self {
    case .letterpress: return NSAttributedString.TextEffectStyle.letterpressStyle.rawValue
    }
  }
}

public typealias TextAttributesBlock = () -> TextAttributes

open class TextAttributes {
  /// The attributes dictionary.
  open fileprivate(set) var dictionary: [NSAttributedStringKey: Any] = [:]

  /**
   Create an instance of TextAttributes.

   - returns: The created TextAttributes.
   */
  public init() {
    dictionary[.paragraphStyle] = paragraphStyle
  }

  fileprivate init(dictionary: [NSAttributedStringKey: Any]) {
    self.dictionary = dictionary
  }

  /**
   Creates a copy of the receiver.

   - returns: A copy of the receiver.
   */
  open func clone() -> TextAttributes {
    let clone = TextAttributes()

    clone.dictionary = dictionary

    if let shadow = shadow?.copy() as? NSShadow {
      clone.shadow = shadow
    }

    clone.attachment = attachment

    clone.paragraphStyle = paragraphStyle.clone()

    return clone
  }

  // MARK: - Font

  /// The font attribute.
  open var font: UIFont? {
    get {
      return dictionary[.font] as? UIFont ?? .h6
    }
    set {
      dictionary[.font] = newValue
    }
  }

  /**
   Sets the font attribute and returns the receiver.

   - parameter name: The fully specified name of the font.
   - parameter size: The size (in points) to which the font is scaled.

   - returns: The receiver.
   */
  @discardableResult
  open func font(name: FontName, size: FontSize) -> Self {
    return font(UIFont(font: name, size: size))
  }

  /**
   Sets the font attribute and returns the receiver.

   - parameter font: The font.

   - returns: The receiver.
   */
  @discardableResult
  open func font(_ font: UIFont?) -> Self {
    self.font = font
    return self
  }

  // MARK: - Ligature

  /// The ligature attribute.
  open var ligature: LigatureStyle {
    get {
      if let int = dictionary[.ligature] as? Int, let ligature = LigatureStyle(rawValue: int) {
        return ligature
      } else {
        return .default
      }
    }

    set {
      dictionary[.ligature] = NSNumber(value: newValue.hashValue)
    }
  }

  /**
   Sets the ligature attribute and returns the receiver.

   - parameter style: The ligature style.

   - returns: The receiver.
   */
  @discardableResult
  open func ligature(_ style: LigatureStyle) -> Self {
    ligature = style
    return self
  }

  // MARK: - Kern

  /// The number of points by which to adjust kern-pair characters.
  open var kern: CGFloat {
    get {
      return dictionary[.kern] as? CGFloat ?? 0
    }

    set {
      dictionary[.kern] = newValue as NSNumber
    }
  }

  /**
   Sets the number of points by which to adjust kern-pair characters and returns the receiver.

   - parameter value: The number of points by which to adjust kern-pair characters.

   - returns: The receiver.
   */
  @discardableResult
  open func kern(_ value: CGFloat) -> Self {
    kern = value
    return self
  }

  // MARK: - Striketrough style

  /// The strikethrough style attribute.
  open var strikethroughStyle: NSUnderlineStyle {
    get {
      if let int = dictionary[.strikethroughStyle] as? Int, let style = NSUnderlineStyle(rawValue: int) {
        return style
      } else {
        return .styleNone
      }
    }

    set {
      dictionary[.strikethroughStyle] = NSNumber(value: newValue.rawValue)
    }
  }

  /**
   Sets the strikethrough style attribute and returns the receiver.

   - parameter style: The strikethrough style.

   - returns: The receiver.
   */
  @discardableResult
  open func strikethroughStyle(_ style: NSUnderlineStyle) -> Self {
    strikethroughStyle = style
    return self
  }

  // MARK: - Strikethrough color

  /// The strikethrough color attribute.
  var strikethroughColor: UIColor? {
    get {
      return dictionary[.strikethroughColor] as? UIColor
    }
    set {
      dictionary[.strikethroughColor] = newValue
    }
  }

  /**
   Sets the strikethrough color attribute and returns the receiver.

   - parameter white: The grayscale value of the color object.
   - parameter alpha: The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func strikethroughColor(white: CGFloat, alpha: CGFloat) -> Self {
    return strikethroughColor(UIColor(white: white, alpha: alpha))
  }

  /**
   Sets the strikethrough color attribute and returns the receiver.

   - parameter hue:        The hue component of the color object.
   - parameter saturation: The saturation component of the color object.
   - parameter brightness: The brightness component of the color object.
   - parameter alpha:      The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func strikethroughColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
    return strikethroughColor(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
  }

  /**
   Sets the strikethrough color attribute and returns the receiver.

   - parameter red:   The red component of the color object.
   - parameter green: The green component of the color object.
   - parameter blue:  The blue component of the color object.
   - parameter alpha: The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func strikethroughColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
    return strikethroughColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
  }

  /**
   Sets the strikethrough color attribute and returns the receiver.

   - parameter image: The image to use when creating the pattern color.

   - returns: The receiver.
   */
  @discardableResult
  open func strikethroughColor(patternImage image: UIImage) -> Self {
    return strikethroughColor(UIColor(patternImage: image))
  }

  /**
   Sets the strikethrough color attribute and returns the receiver.

   - parameter color: The color.

   - returns: The receiver.
   */
  @discardableResult
  open func strikethroughColor(_ color: UIColor?) -> Self {
    strikethroughColor = color
    return self
  }

  // MARK: - Underline style

  /// The underline style attribute.
  open var underlineStyle: NSUnderlineStyle {
    get {
      if let int = dictionary[.underlineStyle] as? Int, let style = NSUnderlineStyle(rawValue: int) {
        return style
      } else {
        return .styleNone
      }
    }

    set {
      dictionary[.underlineStyle] = NSNumber(value: newValue.rawValue)
    }
  }

  /**
   Sets the underline style attribute and returns the receiver.

   - parameter style: The underline style.

   - returns: The receiver.
   */
  @discardableResult
  open func underlineStyle(_ style: NSUnderlineStyle) -> Self {
    underlineStyle = style
    return self
  }

  // MARK: - Underline color

  /// The underline color attribute.
  open var underlineColor: UIColor? {
    get {
      return dictionary[.underlineColor] as? UIColor
    }
    set {
      dictionary[.underlineColor] = newValue
    }
  }

  /**
   Sets the underline color attribute and returns the receiver.

   - parameter white: The grayscale value of the color object.
   - parameter alpha: The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func underlineColor(white: CGFloat, alpha: CGFloat) -> Self {
    return underlineColor(UIColor(white: white, alpha: alpha))
  }

  /**
   Sets the underline color attribute and returns the receiver.

   - parameter hue:        The hue component of the color object.
   - parameter saturation: The saturation component of the color object.
   - parameter brightness: The brightness component of the color object.
   - parameter alpha:      The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func underlineColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
    return underlineColor(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
  }

  /**
   Sets the underline color attribute and returns the receiver.

   - parameter red:   The red component of the color object.
   - parameter green: The green component of the color object.
   - parameter blue:  The blue component of the color object.
   - parameter alpha: The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func underlineColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
    return underlineColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
  }

  /**
   Sets the underline color attribute and returns the receiver.

   - parameter image: The image to use when creating the pattern color.

   - returns: The receiver.
   */
  @discardableResult
  open func underlineColor(patternImage image: UIImage) -> Self {
    return underlineColor(UIColor(patternImage: image))
  }

  /**
   Sets the underline color attribute and returns the receiver.

   - parameter color: The color.

   - returns: The receiver.
   */
  @discardableResult
  open func underlineColor(_ color: UIColor?) -> Self {
    underlineColor = color
    return self
  }

  // MARK: - Stroke color

  /// The stroke color attribute.
  open var strokeColor: UIColor? {
    get {
      return dictionary[.strokeColor] as? UIColor
    }
    set {
      dictionary[.strokeColor] = newValue
    }
  }

  /**
   Sets the stroke color attribute and returns the receiver.

   - parameter white: The grayscale value of the color object.
   - parameter alpha: The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func strokeColor(white: CGFloat, alpha: CGFloat) -> Self {
    return strokeColor(UIColor(white: white, alpha: alpha))
  }

  /**
   Sets the stroke color attribute and returns the receiver.

   - parameter hue:        The hue component of the color object.
   - parameter saturation: The saturation component of the color object.
   - parameter brightness: The brightness component of the color object.
   - parameter alpha:      The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func strokeColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
    return strokeColor(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
  }

  /**
   Sets the stroke color attribute and returns the receiver.

   - parameter red:   The red component of the color object.
   - parameter green: The green component of the color object.
   - parameter blue:  The blue component of the color object.
   - parameter alpha: The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func strokeColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
    return strokeColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
  }

  /**
   Sets the stroke color attribute and returns the receiver.

   - parameter image: The image to use when creating the pattern color.

   - returns: The receiver.
   */
  @discardableResult
  open func strokeColor(patternImage image: UIImage) -> Self {
    return strokeColor(UIColor(patternImage: image))
  }

  /**
   Sets the underline color attribute and returns the receiver.

   - parameter color: The color.

   - returns: The receiver.
   */
  @discardableResult
  open func strokeColor(_ color: UIColor?) -> Self {
    strokeColor = color
    return self
  }

  // MARK: - Stroke width

  /// The stroke width attribute.
  open var strokeWidth: CGFloat {
    get {
      return dictionary[.strokeWidth] as? CGFloat ?? 0
    }
    set {
      dictionary[.strokeWidth] = newValue as NSNumber
    }
  }

  /**
   Sets the stroke width attribute and returns the receiver.

   - parameter width: The stroke width.

   - returns: The receiver.
   */
  @discardableResult
  open func strokeWidth(_ width: CGFloat) -> Self {
    strokeWidth = width
    return self
  }

  // MARK: - Foreground color

  /// The foreground color attribute.
  open var foregroundColor: UIColor? {
    get {
      return dictionary[.foregroundColor] as? UIColor
    }
    set {
      dictionary[.foregroundColor] = newValue
    }
  }

  /**
   Sets the foreground color attribute and returns the receiver.

   - parameter white: The grayscale value of the color object.
   - parameter alpha: The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func foregroundColor(white: CGFloat, alpha: CGFloat) -> Self {
    return foregroundColor(UIColor(white: white, alpha: alpha))
  }

  /**
   Sets the foreground color attribute and returns the receiver.

   - parameter hue:        The hue component of the color object.
   - parameter saturation: The saturation component of the color object.
   - parameter brightness: The brightness component of the color object.
   - parameter alpha:      The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func foregroundColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
    return foregroundColor(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
  }

  /**
   Sets the foreground color attribute and returns the receiver.

   - parameter red:   The red component of the color object.
   - parameter green: The green component of the color object.
   - parameter blue:  The blue component of the color object.
   - parameter alpha: The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func foregroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
    return foregroundColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
  }

  /**
   Sets the foreground color attribute and returns the receiver.

   - parameter image: The image to use when creating the pattern color.

   - returns: The receiver.
   */
  @discardableResult
  open func foregroundColor(patternImage image: UIImage) -> Self {
    return foregroundColor(UIColor(patternImage: image))
  }

  /**
   Sets the foreground color attribute and returns the receiver.

   - parameter color: The color.

   - returns: The receiver.
   */
  @discardableResult
  open func foregroundColor(_ color: UIColor?) -> Self {
    foregroundColor = color
    return self
  }

  // MARK: - TextEffect

  /// The text effect attribute.
  open var textEffect: TextEffect? {
    get {
      if let string = dictionary[.textEffect] as? String, let effect = TextEffect(name: string) {
        return effect
      }
      return nil
    }
    set {
      if let name = newValue?.name {
        dictionary[.textEffect] = NSString(string: name)
      } else {
        dictionary[.textEffect] = nil
      }
    }
  }

  /**
   Sets the text effect attribute and returns the receiver.

   - parameter style: The text effect.

   - returns: The receiver.
   */
  @discardableResult
  open func textEffect(_ style: TextEffect?) -> Self {
    textEffect = style
    return self
  }

  // MARK: - Link

  /// The link attribute.
  open var link: URL? {
    get {
      if let URL = dictionary[.link] as? URL {
        return URL
      } else if let string = dictionary[.link] as? String {
        return URL(string: string)
      } else {
        return nil
      }
    }
    set {
      dictionary[.link] = newValue
    }
  }

  /**
   Sets the link attribute and returns the receiver.

   - parameter string: The URL string with which to initialize the NSURL object.

   - returns: The receiver.
   */
  @discardableResult
  open func link(string: String) -> Self {
    return link(URL(string: string))
  }

  /**
   Sets the link attribute and returns the receiver.

   - parameter string:  The URL string with which to initialize the NSURL object.
   - parameter baseURL: The base URL for the NSURL object.

   - returns: The receiver.
   */
  @discardableResult
  open func link(string: String, relativeToURL baseURL: URL) -> Self {
    return link(URL(string: string, relativeTo: baseURL))
  }

  /**
   Sets the link attribute and returns the receiver.

   - parameter URL: The URL.

   - returns: The receiver.
   */
  @discardableResult
  open func link(_ URL: URL?) -> Self {
    link = URL
    return self
  }

  // MARK: - Baseline offset

  /// The baseline offset attribute.
  open var baselineOffset: CGFloat {
    get {
      return dictionary[.baselineOffset] as? CGFloat ?? 0
    }
    set {
      dictionary[.baselineOffset] = newValue as NSNumber
    }
  }

  /**
   Sets the baseline offset attribute and return the receiver.

   - parameter value: The baseline offset.

   - returns: The receiver.
   */
  @discardableResult
  open func baselineOffset(_ value: CGFloat) -> Self {
    baselineOffset = value
    return self
  }

  // MARK: - Obliqueness

  /// The obliqueness attribute.
  open var obliqueness: CGFloat {
    get {
      return dictionary[.obliqueness] as? CGFloat ?? 0
    }
    set {
      dictionary[.obliqueness] = newValue as NSNumber
    }
  }

  /**
   Sets the obliqueness attribute and returns the receiver.

   - parameter value: The obliqueness.

   - returns: The receiver.
   */
  @discardableResult
  open func obliqueness(_ value: CGFloat) -> Self {
    obliqueness = value
    return self
  }

  // MARK: - Expansion

  /// The expansion attribute.
  open var expansion: CGFloat {
    get {
      return dictionary[.expansion] as? CGFloat ?? 0
    }
    set {
      dictionary[.expansion] = newValue as NSNumber
    }
  }

  /**
   Sets the expansion attribute and returns the receiver.

   - parameter value: The expansion attribute.

   - returns: The receiver.
   */
  @discardableResult
  open func expansion(_ value: CGFloat) -> Self {
    expansion = value
    return self
  }

  // MARK: - Vertical glyph form

  /// The vertical glyph form attribute.
  open var verticalGlyphForm: VerticalGlyphForm {
    get {
      if let int = dictionary[.verticalGlyphForm] as? Int, let form = VerticalGlyphForm(rawValue: int) {
        return form
      } else {
        return .horizontal
      }
    }
    set {
      dictionary[.verticalGlyphForm] = NSNumber(value: newValue.hashValue)
    }
  }

  /**
   Sets the vertical glyph form attribute and returns the receiver.

   - parameter value: The vertical glyph form.

   - returns: The receiver.
   */
  @discardableResult
  open func verticalGlyphForm(_ value: VerticalGlyphForm) -> Self {
    verticalGlyphForm = value
    return self
  }

  // MARK: - Background color

  /// The background color attribute.
  var backgroundColor: UIColor? {
    get {
      return dictionary[.backgroundColor] as? UIColor
    }
    set {
      dictionary[.backgroundColor] = newValue
    }
  }

  /**
   Sets the background color attribute and returns the receiver.

   - parameter white: The grayscale value of the color object.
   - parameter alpha: The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func backgroundColor(white: CGFloat, alpha: CGFloat) -> Self {
    return backgroundColor(UIColor(white: white, alpha: alpha))
  }

  /**
   Sets the background color attribute and returns the receiver.

   - parameter hue:        The hue component of the color object.
   - parameter saturation: The saturation component of the color object.
   - parameter brightness: The brightness component of the color object.
   - parameter alpha:      The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func backgroundColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
    return backgroundColor(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
  }

  /**
   Sets the background color attribute and returns the receiver.

   - parameter red:   The red component of the color object.
   - parameter green: The green component of the color object.
   - parameter blue:  The blue component of the color object.
   - parameter alpha: The opacity value of the color object.

   - returns: The receiver.
   */
  @discardableResult
  open func backgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
    return backgroundColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
  }

  /**
   Sets the background color attribute and returns the receiver.

   - parameter image: The image to use when creating the pattern color.

   - returns: The receiver.
   */
  @discardableResult
  open func backgroundColor(patternImage image: UIImage) -> Self {
    return backgroundColor(UIColor(patternImage: image))
  }

  /**
   Sets the background color attribute and returns the receiver.

   - parameter color: The color.

   - returns: The receiver.
   */
  @discardableResult
  open func backgroundColor(_ color: UIColor?) -> Self {
    backgroundColor = color
    return self
  }

  // MARK: - Paragraph style

  /// The paragraph style attribute.
  open var paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle() {
    didSet {
      dictionary[.paragraphStyle] = paragraphStyle
    }
  }

  /**
   Sets the paragraph style attribute and returns the receiver.

   - parameter style: The paragraph style.

   - returns: The receiver.
   */
  @discardableResult
  open func paragraphStyle(_ style: NSMutableParagraphStyle) -> Self {
    paragraphStyle = style
    return self
  }

  // MARK: - Alignment

  /// The text alignment of the paragraph style.
  open var alignment: NSTextAlignment {
    get { return paragraphStyle.alignment }
    set { paragraphStyle.alignment = newValue }
  }

  /**
   Sets the text alignment of the paragraph style and returns the receiver.

   - parameter alignment: The text alignment.

   - returns: The receiver.
   */
  @discardableResult
  open func alignment(_ alignment: NSTextAlignment) -> Self {
    self.alignment = alignment
    return self
  }

  // MARK: - First line head indent

  /// The indentation of the first line of the paragraph style.
  open var firstLineHeadIndent: CGFloat {
    get { return paragraphStyle.firstLineHeadIndent }
    set { paragraphStyle.firstLineHeadIndent = newValue }
  }

  /**
   Sets the indentation of the first line of the paragraph style and returns the receiver.

   - parameter value: The indentation.

   - returns: The receiver.
   */
  @discardableResult
  open func firstLineHeadIndent(_ value: CGFloat) -> Self {
    firstLineHeadIndent = value
    return self
  }

  // MARK: - Head indent

  /// The indentation of the paragraph style lines other than the first.
  open var headIndent: CGFloat {
    get { return paragraphStyle.headIndent }
    set { paragraphStyle.headIndent = newValue }
  }

  /**
   Sets the indentation of the paragraph style lines other than the first and returns the receiver.

   - parameter value: The indentation of the lines other than the first.

   - returns: The receiver.
   */
  @discardableResult
  open func headIndent(_ value: CGFloat) -> Self {
    headIndent = value
    return self
  }

  // MARK: - Tail indent

  /// The trailing indentation of the paragraph style.
  open var tailIndent: CGFloat {
    get { return paragraphStyle.tailIndent }
    set { paragraphStyle.tailIndent = newValue }
  }

  /**
   Sets the trailing indentation of the paragraph style and returns the receiver.

   - parameter value: The trailing indentation.

   - returns: The receiver.
   */
  @discardableResult
  open func tailIndent(_ value: CGFloat) -> Self {
    tailIndent = value
    return self
  }

  // MARK: - Line height multiple

  /// The line height multiple of the paragraph style.
  open var lineHeightMultiple: CGFloat {
    get { return paragraphStyle.lineHeightMultiple }
    set { paragraphStyle.lineHeightMultiple = newValue }
  }

  /**
   Sets the line height multiple of the paragraph style and returns the receiver.

   - parameter value: The line height multiple.

   - returns: The receiver.
   */
  @discardableResult
  open func lineHeightMultiple(_ value: CGFloat) -> Self {
    lineHeightMultiple = value
    return self
  }

  // MARK: - Maximum line height

  /// The maximum line height of the paragraph style.
  open var maximumLineHeight: CGFloat {
    get { return paragraphStyle.maximumLineHeight }
    set { paragraphStyle.maximumLineHeight = newValue }
  }

  /**
   Sets the maximum line height of the paragraph style and returns the receiver.

   - parameter value: The maximum line height.

   - returns: The receiver.
   */
  @discardableResult
  open func maximumLineHeight(_ value: CGFloat) -> Self {
    maximumLineHeight = value
    return self
  }

  // MARK: - Minimum line height

  /// The minimum line height of the paragraph style.
  open var minimumLineHeight: CGFloat {
    get { return paragraphStyle.minimumLineHeight }
    set { paragraphStyle.minimumLineHeight = newValue }
  }

  /**
   Sets the minimum line height of the paragraph style and returns the receiver.

   - parameter value: The minimum line height.

   - returns: The receiver.
   */
  @discardableResult
  open func minimumLineHeight(_ value: CGFloat) -> Self {
    minimumLineHeight = value
    return self
  }

  // MARK: - Line spacing

  /// The line spacing of the paragraph style.
  open var lineSpacing: CGFloat {
    get { return paragraphStyle.lineSpacing }
    set { paragraphStyle.lineSpacing = newValue }
  }

  /**
   Sets the line spacing of the paragraph style and returns the receiver.

   - parameter value: The line spacing.

   - returns: The receiver.
   */
  @discardableResult
  open func lineSpacing(_ value: CGFloat) -> Self {
    lineSpacing = value
    return self
  }

  // MARK: - Paragraph spacing

  /// The paragraph spacing of the paragraph style.
  open var paragraphSpacing: CGFloat {
    get { return paragraphStyle.paragraphSpacing }
    set { paragraphStyle.paragraphSpacing = newValue }
  }

  /**
   Sets the paragraph spacing of the paragraph style and returns the receiver.

   - parameter value: The paragraph spacing.

   - returns: The receiver.
   */
  @discardableResult
  open func paragraphSpacing(_ value: CGFloat) -> Self {
    paragraphSpacing = value
    return self
  }

  // MARK: - Paragraph spacing before

  /// The distance between the paragraph's top and the beginning of its text content.
  open var paragraphSpacingBefore: CGFloat {
    get { return paragraphStyle.paragraphSpacingBefore }
    set { paragraphStyle.paragraphSpacingBefore = newValue }
  }

  /**
   Sets the distance between the paragraph's top and the beginning of its text content and returns the receiver.

   - parameter value: The distance between the paragraph's top and the beginning of its text content.

   - returns: The receiver.
   */
  @discardableResult
  open func paragraphSpacingBefore(_ value: CGFloat) -> Self {
    paragraphSpacingBefore = value
    return self
  }

  // MARK: - Line Break Mode

  /// The mode that should be used to break lines.
  open var lineBreakMode: NSLineBreakMode {
    get { return paragraphStyle.lineBreakMode }
    set { paragraphStyle.lineBreakMode = newValue }
  }

  /**
   Sets the mode that should be used to break lines and returns the receiver.

   - parameter value: The mode that should be used to break lines.

   - returns: The receiver.
   */
  @discardableResult
  open func lineBreakMode(_ value: NSLineBreakMode) -> Self {
    lineBreakMode = value
    return self
  }
}

extension TextAttributes {

  // MARK: - Shadow

  /// The shadow attribute.
  public var shadow: NSShadow? {
    get {
      return dictionary[.shadow] as? NSShadow
    }
    set {
      dictionary[.shadow] = newValue
    }
  }

  /**
   Sets the shadow attribute and returns the receiver.

   - parameter color:      The color of the shadow.
   - parameter offset:     The offset values of the shadow.
   - parameter blurRadius: The blur radius of the shadow.

   - returns: The receiver.
   */
  @discardableResult
  public func shadow(color: AnyObject?, offset: CGSize, blurRadius: CGFloat) -> Self {
    return shadow({
      let shadow = NSShadow()
      shadow.shadowColor = color
      shadow.shadowOffset = offset
      shadow.shadowBlurRadius = blurRadius
      return shadow
    }() as NSShadow)
  }

  /**
   Sets the shadow attribute and returns the receiver.

   - parameter shadow: The shadow.

   - returns: The receiver.
   */
  @discardableResult
  public func shadow(_ shadow: NSShadow?) -> Self {
    self.shadow = shadow
    return self
  }

  // MARK: - Attachment

  /// The attachment attribute.
  public var attachment: NSTextAttachment? {
    get {
      return dictionary[.attachment] as? NSTextAttachment
    }
    set {
      dictionary[.attachment] = newValue
    }
  }

  /**
   Sets the attachment attribute and returns the receiver.

   - parameter attachment: The text attachment.

   - returns: The receiver.
   */
  @discardableResult
  public func attachment(_ attachment: NSTextAttachment?) -> Self {
    self.attachment = attachment
    return self
  }
}

// MARK: - Attributed strings -

extension NSAttributedString {
  /**
   Returns an NSAttributedString object initialized with a given string and attributes.

   - parameter string:     The string for the new attributed string.
   - parameter attributes: The attributes for the new attributed string.

   - returns: The newly created NSAttributedString.
   */
  public convenience init(string: NSString, attributes: TextAttributes) {
    self.init(string: string as String, attributes: attributes)
  }

  /**
   Returns an NSAttributedString object initialized with a given string and attributes.

   - parameter string:     The string for the new attributed string.
   - parameter attributes: The attributes for the new attributed string.

   - returns: The newly created NSAttributedString.
   */
  public convenience init(string: String, attributes: TextAttributes) {
    self.init(string: string, attributes: attributes.dictionary)
  }

  public convenience init(string: NSString, block: TextAttributesBlock) {
    self.init(string: string as String, block: block)
  }

  public convenience init(string: String, block: TextAttributesBlock) {
    self.init(string: string, attributes: block().dictionary)
  }
}

extension NSMutableAttributedString {
  /**
   Sets the attributes to the specified attributes.

   - parameter attributes: The attributes to set.
   */
  public func setAttributes(_ attributes: TextAttributes) {
    setAttributes(attributes, range: NSRange(mutableString))
  }

  /**
   Sets the attributes for the characters in the specified range to the specified attributes.

   - parameter attributes: The attributes to set.
   - parameter range:      The range of characters whose attributes are set.
   */
  public func setAttributes(_ attributes: TextAttributes, range: Range<Int>) {
    setAttributes(attributes, range: NSRange(range))
  }

  /**
   Sets the attributes for the characters in the specified range to the specified attributes.

   - parameter attributes: The attributes to set.
   - parameter range:      The range of characters whose attributes are set.
   */
  public func setAttributes(_ attributes: TextAttributes, range: NSRange) {
    setAttributes(attributes.dictionary, range: range)
  }

  /**
   Adds the given attributes.

   - parameter attributes: The attributes to add.
   */
  public func addAttributes(_ attributes: TextAttributes) {
    addAttributes(attributes, range: NSRange(mutableString))
  }

  /**
   Adds the given collection of attributes to the characters in the specified range.

   - parameter attributes: The attributes to add.
   - parameter range:      he range of characters to which the specified attributes apply.
   */
  public func addAttributes(_ attributes: TextAttributes, range: Range<Int>) {
    addAttributes(attributes, range: NSRange(range))
  }

  /**
   Adds the given collection of attributes to the characters in the specified range.

   - parameter attributes: The attributes to add.
   - parameter range:      he range of characters to which the specified attributes apply.
   */
  public func addAttributes(_ attributes: TextAttributes, range: NSRange) {
    addAttributes(attributes.dictionary, range: range)
  }

  @discardableResult
  public func append(_ string: String, block: TextAttributesBlock) -> Self {
    append(NSAttributedString(string: string, block: block))
    return self
  }
}

// MARK: - String, NSString -

extension String {
  public func attributed(_ block: () -> TextAttributes) -> NSAttributedString {
    return NSAttributedString(string: self, block: block)
  }
}

extension NSString {
  public func attributed(_ block: () -> TextAttributes) -> NSAttributedString {
    return NSAttributedString(string: self, block: block)
  }
}

// MARK: - Range, Paragraph helpers -

extension NSRange {
  init(_ range: Range<Int>) {
    self = NSRange(location: range.lowerBound, length: range.count)
  }

  init(_ string: NSString) {
    self = NSRange(location: 0, length: string.length)
  }
}

extension NSMutableParagraphStyle {
  func clone() -> NSMutableParagraphStyle {
    let clone = NSMutableParagraphStyle()

    if #available(iOS 9.0, *) {
      clone.setParagraphStyle(self)
    } else {
      clone.cloneParagraphStyle(self)
    }

    return clone
  }

  fileprivate func cloneParagraphStyle(_ other: NSMutableParagraphStyle) {
    alignment = other.alignment
    firstLineHeadIndent = other.firstLineHeadIndent
    headIndent = other.headIndent
    tailIndent = other.tailIndent
    lineBreakMode = other.lineBreakMode
    maximumLineHeight = other.maximumLineHeight
    minimumLineHeight = other.minimumLineHeight
    lineSpacing = other.lineSpacing
    paragraphSpacing = other.paragraphSpacing
    paragraphSpacingBefore = other.paragraphSpacingBefore
    baseWritingDirection = other.baseWritingDirection
    lineHeightMultiple = other.lineHeightMultiple
//        hyphenationFactor      = other.hyphenationFactor
//        tabStops               = other.tabStops
//        defaultTabInterval     = other.defaultTabInterval
//        allowsDefaultTighteningForTruncation = other.allowsDefaultTighteningForTruncation (iOS 9)
  }
}

// MARK: - Operators -

public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
  let result = NSMutableAttributedString()
  result.append(lhs)
  result.append(rhs)
  return NSAttributedString(attributedString: result)
}

public func + (lhs: NSParagraphStyle, rhs: NSParagraphStyle) -> NSParagraphStyle {
  let defaultParagraph = NSParagraphStyle.default
  let combinedAttributes = lhs.mutableCopy() as! NSMutableParagraphStyle

  if rhs.alignment != defaultParagraph.alignment {
    combinedAttributes.alignment = rhs.alignment
  }

  if rhs.firstLineHeadIndent != defaultParagraph.firstLineHeadIndent {
    combinedAttributes.firstLineHeadIndent = rhs.firstLineHeadIndent
  }

  if rhs.headIndent != defaultParagraph.headIndent {
    combinedAttributes.headIndent = rhs.headIndent
  }

  if rhs.tailIndent != defaultParagraph.tailIndent {
    combinedAttributes.tailIndent = rhs.tailIndent
  }

  if rhs.lineBreakMode != defaultParagraph.lineBreakMode {
    combinedAttributes.lineBreakMode = rhs.lineBreakMode
  }

  if rhs.minimumLineHeight != defaultParagraph.minimumLineHeight {
    combinedAttributes.minimumLineHeight = rhs.minimumLineHeight
  }

  if rhs.maximumLineHeight != defaultParagraph.maximumLineHeight {
    combinedAttributes.maximumLineHeight = rhs.maximumLineHeight
  }

  if rhs.lineSpacing != defaultParagraph.lineSpacing {
    combinedAttributes.lineSpacing = rhs.lineSpacing
  }

  if rhs.paragraphSpacing != defaultParagraph.paragraphSpacing {
    combinedAttributes.paragraphSpacing = rhs.paragraphSpacing
  }

  if rhs.paragraphSpacingBefore != defaultParagraph.paragraphSpacingBefore {
    combinedAttributes.paragraphSpacingBefore = rhs.paragraphSpacingBefore
  }

  if rhs.baseWritingDirection != defaultParagraph.baseWritingDirection {
    combinedAttributes.baseWritingDirection = rhs.baseWritingDirection
  }

  if rhs.lineHeightMultiple != defaultParagraph.lineHeightMultiple {
    combinedAttributes.lineHeightMultiple = rhs.lineHeightMultiple
  }

  if rhs.hyphenationFactor != defaultParagraph.hyphenationFactor {
    combinedAttributes.hyphenationFactor = rhs.hyphenationFactor
  }

  if rhs.tabStops != defaultParagraph.tabStops {
    combinedAttributes.tabStops = rhs.tabStops
  }

  if rhs.defaultTabInterval != defaultParagraph.defaultTabInterval {
    combinedAttributes.defaultTabInterval = rhs.defaultTabInterval
  }

  if #available(iOS 9.0, *) {
    if rhs.allowsDefaultTighteningForTruncation != defaultParagraph.allowsDefaultTighteningForTruncation {
      combinedAttributes.allowsDefaultTighteningForTruncation = rhs.allowsDefaultTighteningForTruncation
    }
  }

  return combinedAttributes
}

public func + (lhs: TextAttributes, rhs: TextAttributes) -> TextAttributes {
  var combined = lhs.dictionary
  for (key, value) in rhs.dictionary {
    combined[key] = value
  }

  let combinedParagraphStyle: NSParagraphStyle?
  let lhsParagraphStyle = lhs.dictionary[.paragraphStyle] as? NSParagraphStyle
  let rhsParagraphStyle = rhs.dictionary[.paragraphStyle] as? NSParagraphStyle

  if let lhsParagraphStyle = lhsParagraphStyle, let rhsParagraphStyle = rhsParagraphStyle {
    combinedParagraphStyle = lhsParagraphStyle + rhsParagraphStyle
  } else {
    combinedParagraphStyle = lhsParagraphStyle ?? rhsParagraphStyle
  }

  if let paragraphStyle = combinedParagraphStyle {
    combined[.paragraphStyle] = paragraphStyle
  }

  return TextAttributes(dictionary: combined)
}
