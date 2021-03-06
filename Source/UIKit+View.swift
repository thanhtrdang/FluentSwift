//
//  UIKit+View.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/16/17.
//  Copyright © 2017 Uta Apps. All rights reserved.
//

// swiftlint:disable file_length

import UIKit

// MARK: View -

public extension UIView {
  @discardableResult
  public func tag(_ tag: Int) -> Self {
    self.tag = tag
    return self
  }

  @discardableResult
  public func isUserInteractionEnabled(_ enabled: Bool) -> Self {
    isUserInteractionEnabled = enabled
    return self
  }
}

// MARK: - Control -

public extension UIControl {
  @discardableResult
  public func isEnabled(_ enabled: Bool) -> Self {
    isEnabled = enabled
    return self
  }

  @discardableResult
  public func isSelected(_ selected: Bool) -> Self {
    isSelected = selected
    return self
  }

  @discardableResult
  public func isHighlighted(_ highlighted: Bool) -> Self {
    isHighlighted = highlighted
    return self
  }

  @discardableResult
  public func align(vertical: UIControlContentVerticalAlignment = .center,
                    horizontal: UIControlContentHorizontalAlignment = .center) -> Self {
    contentVerticalAlignment = vertical
    contentHorizontalAlignment = horizontal
    return self
  }
}

// MARK: - Button -

public extension UIButton {
  @discardableResult
  public func title(_ title: String, for state: UIControlState = .normal) -> Self {
    setTitle(title, for: state)
    return self
  }

  @discardableResult
  public func title(byKey key: String, for state: UIControlState = .normal) -> Self {
    title(NSLocalizedString(key, comment: ""), for: state)
    return self
  }

  @discardableResult
  public func font(_ font: UIFont) -> Self {
    titleLabel?.font = font
    return self
  }

  @discardableResult
  public func color(_ color: UIColor, for state: UIControlState = .normal) -> Self {
    setTitleColor(color, for: state)
    return self
  }

  @discardableResult
  public func attributedTitle(_ attributedTitle: NSAttributedString, for state: UIControlState = .normal) -> Self {
    setAttributedTitle(attributedTitle, for: state)
    return self
  }

  @discardableResult
  public func image(_ image: UIImage, for state: UIControlState = .normal) -> Self {
    setImage(image, for: state)
    return self
  }

  @discardableResult
  public func background(_ background: UIImage, for state: UIControlState = .normal) -> Self {
    setBackgroundImage(background, for: state)
    return self
  }

  @discardableResult
  public func background(color: UIColor) -> Self {
    backgroundColor = color
    return self
  }
}

// MARK: - TODO - Make it protocol and resolve Optional later

/* Copy & paste
 extension UITextable {
 @discardableResult
 public func text(_ text: String) -> Self {
 self.text = text
 return self
 }

 @discardableResult
 public func text(byKey key: String) -> Self {
 text(NSLocalizedString(key, comment: ""))
 return self
 }

 @discardableResult
 public func font(_ font: UIFont) -> Self {
 self.font = font
 return self
 }

 @discardableResult
 public func color(_ color: UIColor) -> Self {
 textColor = color
 return self
 }

 @discardableResult
 public func align(_ align: NSTextAlignment) -> Self {
 textAlignment = align
 return self
 }

 @discardableResult
 public func attributedText(_ attributedText: NSAttributedString) -> Self {
 self.attributedText = attributedText
 return self
 }

 }
 */

// MARK: - Label -

public extension UILabel {
  @discardableResult
  public func text(_ text: String) -> Self {
    self.text = text
    return self
  }

  @discardableResult
  public func text(byKey key: String) -> Self {
    text(NSLocalizedString(key, comment: ""))
    return self
  }

  @discardableResult
  public func font(_ font: UIFont) -> Self {
    self.font = font
    return self
  }

  @discardableResult
  public func color(_ color: UIColor) -> Self {
    textColor = color
    return self
  }

  @discardableResult
  public func align(_ align: NSTextAlignment) -> Self {
    textAlignment = align
    return self
  }

  @discardableResult
  public func attributedText(_ attributedText: NSAttributedString) -> Self {
    self.attributedText = attributedText
    return self
  }

  @discardableResult
  public func fontFitWidth(_ fit: Bool) -> Self {
    adjustsFontSizeToFitWidth = fit
    return self
  }

  @discardableResult
  public func lineBreak(_ mode: NSLineBreakMode) -> Self {
    lineBreakMode = mode
    return self
  }

  @discardableResult
  public func numberOfLines(_ lines: Int) -> Self {
    numberOfLines = lines
    return self
  }

  @discardableResult
  public func minimumScaleFactor(_ scaleFactor: CGFloat) -> Self {
    minimumScaleFactor = scaleFactor
    return self
  }

  @available(iOS 9.0, *)
  @discardableResult
  public func tighten(_ tighten: Bool) -> Self {
    allowsDefaultTighteningForTruncation = tighten
    return self
  }
}

// MARK: - TextField -

public extension UITextField {
  @discardableResult
  public func text(_ text: String) -> Self {
    self.text = text
    return self
  }

  @discardableResult
  public func text(byKey key: String) -> Self {
    text(NSLocalizedString(key, comment: ""))
    return self
  }

  @discardableResult
  public func font(_ font: UIFont) -> Self {
    self.font = font
    return self
  }

  @discardableResult
  public func color(_ color: UIColor) -> Self {
    textColor = color
    return self
  }

  @discardableResult
  public func align(_ align: NSTextAlignment) -> Self {
    textAlignment = align
    return self
  }

  @discardableResult
  public func attributedText(_ attributedText: NSAttributedString) -> Self {
    self.attributedText = attributedText
    return self
  }

  @discardableResult
  public func fontFitWidth(_ fit: Bool) -> Self {
    adjustsFontSizeToFitWidth = fit
    return self
  }

  @discardableResult
  public func minimumFontSize(_ minimumFontSize: CGFloat) -> Self {
    self.minimumFontSize = minimumFontSize
    return self
  }

  @discardableResult
  public func placeholder(_ text: String) -> Self {
    placeholder = text
    return self
  }

  @discardableResult
  public func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString) -> Self {
    self.attributedPlaceholder = attributedPlaceholder
    return self
  }

  @discardableResult
  public func border(style: UITextBorderStyle) -> Self {
    borderStyle = style
    return self
  }

  @discardableResult
  public func background(_ background: UIImage) -> Self {
    self.background = background
    return self
  }

  @discardableResult
  public func background(disabled background: UIImage) -> Self {
    disabledBackground = background
    return self
  }

  @discardableResult
  public func clearButtonDisplay(on mode: UITextFieldViewMode) -> Self {
    clearButtonMode = mode
    return self
  }

  @discardableResult
  public func clearsOn(beginEditing: Bool = false, insertion: Bool = false) -> Self {
    clearsOnBeginEditing = beginEditing
    clearsOnInsertion = insertion

    return self
  }

  @discardableResult
  public func leftView(_ view: UIView, mode: UITextFieldViewMode) -> Self {
    leftView = view
    leftViewMode = mode

    return self
  }

  @discardableResult
  public func rightView(_ view: UIView, mode: UITextFieldViewMode) -> Self {
    rightView = view
    rightViewMode = mode

    return self
  }

  @discardableResult
  public func inputView(_ view: UIView, accessory: UIView) -> Self {
    inputView = view
    inputAccessoryView = accessory

    return self
  }

  // UITextInputTraits

  @discardableResult
  public func autocapitalizationType(_ type: UITextAutocapitalizationType) -> Self {
    autocapitalizationType = type
    return self
  }

  @discardableResult
  public func autocorrectionType(_ type: UITextAutocorrectionType) -> Self {
    autocorrectionType = type
    return self
  }

  @discardableResult
  public func spellCheckingType(_ type: UITextSpellCheckingType) -> Self {
    spellCheckingType = type
    return self
  }

  @discardableResult
  public func keyboardType(_ type: UIKeyboardType) -> Self {
    keyboardType = type
    return self
  }

  @discardableResult
  public func keyboardStyle(_ style: UIKeyboardAppearance) -> Self {
    keyboardAppearance = style
    return self
  }

  @discardableResult
  public func returnKeyType(_ type: UIReturnKeyType) -> Self {
    returnKeyType = type
    return self
  }

  @discardableResult
  public func returnKeyWhenEmpty(disabled: Bool) -> Self {
    enablesReturnKeyAutomatically = disabled
    return self
  }

  @discardableResult
  public func isSecureTextEntry(_ secured: Bool) -> Self {
    isSecureTextEntry = secured
    return self
  }

  @available(iOS 10.0, *)
  @discardableResult
  public func textContentType(_ type: UITextContentType) -> Self {
    textContentType = type
    return self
  }
}

// MARK: - TextView -

public extension UITextView {
  @discardableResult
  public func text(_ text: String) -> Self {
    self.text = text
    return self
  }

  @discardableResult
  public func text(byKey key: String) -> Self {
    text(NSLocalizedString(key, comment: ""))
    return self
  }

  @discardableResult
  public func font(_ font: UIFont) -> Self {
    self.font = font
    return self
  }

  @discardableResult
  public func color(_ color: UIColor) -> Self {
    textColor = color
    return self
  }

  @discardableResult
  public func align(_ align: NSTextAlignment) -> Self {
    textAlignment = align
    return self
  }

  @discardableResult
  public func attributedText(_ attributedText: NSAttributedString) -> Self {
    self.attributedText = attributedText
    return self
  }

  @discardableResult
  public func isEditable(_ editable: Bool) -> Self {
    isEditable = editable
    return self
  }

  @discardableResult
  public func isSelectable(_ selectable: Bool) -> Self {
    isSelectable = selectable
    return self
  }

  @discardableResult
  public func clearsOn(insertion: Bool) -> Self {
    clearsOnInsertion = insertion
    return self
  }

  @discardableResult
  public func selectedRange(_ range: NSRange) -> Self {
    selectedRange = range
    return self
  }

  @discardableResult
  public func dataDetector(_ types: UIDataDetectorTypes) -> Self {
    dataDetectorTypes = types
    return self
  }
}
