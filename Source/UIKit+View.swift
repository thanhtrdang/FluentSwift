//
//  UIKit+View.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/16/17.
//  Copyright © 2017 Uta Apps. All rights reserved.
//

import UIKit

//MARK: View -
public extension UIView {
    @discardableResult
    public func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    @discardableResult
    public func isUserInteractionEnabled(_ enabled: Bool) -> Self {
        self.isUserInteractionEnabled = enabled
        return self
    }
}

//MARK: - Control -
public extension UIControl {
    @discardableResult
    public func isEnabled(_ enabled: Bool) -> Self {
        self.isEnabled = enabled
        return self
    }
    @discardableResult
    public func isSelected(_ selected: Bool) -> Self {
        self.isSelected = selected
        return self
    }
    @discardableResult
    public func isHighlighted(_ highlighted: Bool) -> Self {
        self.isHighlighted = highlighted
        return self
    }
    @discardableResult
    public func align(vertical: UIControlContentVerticalAlignment = .center, horizontal: UIControlContentHorizontalAlignment = .center) -> Self {
        self.contentVerticalAlignment = vertical
        self.contentHorizontalAlignment = horizontal
        return self
    }
}

//MARK: - Button -
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

//MARK: - Label -
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
        self.adjustsFontSizeToFitWidth = fit
        return self
    }
    
    @discardableResult
    public func lineBreak(_ mode: NSLineBreakMode) -> Self {
        self.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    public func numberOfLines(_ lines: Int) -> Self {
        self.numberOfLines = lines
        return self
    }
    
    @discardableResult
    public func minimumScaleFactor(_ scaleFactor: CGFloat) -> Self {
        self.minimumScaleFactor = scaleFactor
        return self
    }
    
    @available(iOS 9.0, *)
    @discardableResult
    public func tighten(_ tighten: Bool) -> Self {
        self.allowsDefaultTighteningForTruncation = tighten
        return self
    }
}

//MARK: - TextField -
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
        self.adjustsFontSizeToFitWidth = fit
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
        self.disabledBackground = background
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

}

//MARK: - TextView -
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
        self.isEditable = editable
        return self
    }

    @discardableResult
    public func isSelectable(_ selectable: Bool) -> Self {
        self.isSelectable = selectable
        return self
    }

    @discardableResult
    public func clearsOn(insertion: Bool) -> Self {
        clearsOnInsertion = insertion
        return self
    }

    @discardableResult
    public func selectedRange(_ range: NSRange) -> Self {
        self.selectedRange = range
        return self
    }
    
    @discardableResult
    public func dataDetector(_ types: UIDataDetectorTypes) -> Self {
        self.dataDetectorTypes = types
        return self
    }
    
}
