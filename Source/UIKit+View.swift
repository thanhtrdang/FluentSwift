//
//  UIKit+View.swift
//  HomeLand-Prototype
//
//  Created by Thanh Dang on 5/16/17.
//  Copyright © 2017 Uta Apps. All rights reserved.
//

import UIKit

//TODO
/*
 
    - border
    - corner radius
    - mask
    - shadow
    - gradient
    - blur effect
 
 */

//MARK: Border -
fileprivate enum BorderSide {
    case top
    case right
    case bottom
    case left
}
public struct BorderSides: OptionSet {
    public let rawValue: Int
    
    public static let unknown = BorderSides(rawValue: 0)
    public static let top = BorderSides(rawValue: 1)
    public static let right = BorderSides(rawValue: 1 << 1)
    public static let bottom = BorderSides(rawValue: 1 << 2)
    public static let left = BorderSides(rawValue: 1 << 3)
    public static let all: BorderSides = [.top, .right, .bottom, .left]
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    fileprivate init(side: BorderSide?) {
        guard let side = side else {
            self = .unknown
            return
        }
        
        switch side {
        case .top: self = .top
        case .right: self = .right
        case .bottom: self = .bottom
        case .left: self = .left
        }
    }
}
public enum BorderType {
    case solid
    case dash(dashLength: Int, spaceLength: Int)
    case none
}
extension BorderType: Equatable {
    public static func ==(lhs: BorderType, rhs: BorderType) -> Bool {
        switch (lhs, rhs) {
        case (.solid, .solid):
            return true
        case (.dash, .dash):
            return true
        default:
            return false
        }
    }
}

//MARK: - UIView - border -
extension UIView {
    @discardableResult
    public func border(type: BorderType = .solid, color: UIColor? = .grey40, width: CGFloat = 1, sides: BorderSides = .all) -> Self {

        //FIXME
//        if self is UITextField && width > 0 {
//            type = .none
//        }
        
        guard color != nil, width > 0 else {
            clearLayer()
            return self
        }
        
        clearLayer()
        if let mask = layer.mask as? CAShapeLayer {
            applyBorderOnMask(mask, color: color, width: width)
        } else {
            drawBorders(type: type, sides: sides, color: color, width: width)
        }

        return self
    }
    
    fileprivate func clearLayer() {
        layer.borderColor = nil
        layer.borderWidth = 0
        layer.sublayers?
            .filter { $0.name == "borderSideLayer" || $0.name == "borderAllSides" }
            .forEach { $0.removeFromSuperlayer() }
    }
    fileprivate func applyBorderOnMask(_ mask: CAShapeLayer, color: UIColor?, width: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.name = "borderAllSides"
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color!.cgColor
        borderLayer.lineWidth = width
        borderLayer.frame = bounds
        layer.insertSublayer(borderLayer, at: 0)
    }

    fileprivate func drawBorders(type: BorderType, sides: BorderSides, color: UIColor?, width: CGFloat) {
        if type == .solid, sides == .all {
            layer.borderColor = color!.cgColor
            layer.borderWidth = width
        } else {
            drawBordersSides(type: type, sides: sides, color: color, width: width)
        }
    }
    
    fileprivate func drawBordersSides(type: BorderType, sides: BorderSides, color: UIColor?, width: CGFloat) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "borderSideLayer"
        shapeLayer.path = makeBorderPath(sides: sides, width: width).cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color!.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.frame = bounds
        switch type {
        case let .dash(dashLength, spaceLength):
            shapeLayer.lineJoin = kCALineJoinRound
            shapeLayer.lineDashPattern = [dashLength as NSNumber, spaceLength as NSNumber]
        case .solid, .none:
            break
        }
        layer.insertSublayer(shapeLayer, at: 0)
    }
    
    fileprivate func makeBorderPath(sides: BorderSides, width: CGFloat) -> UIBezierPath {
        let lines = makeLines(sides: sides, width: width)
        let borderPath = UIBezierPath()
        lines.forEach {
            borderPath.move(to: $0.start)
            borderPath.addLine(to: $0.end)
        }
        return borderPath
    }

    fileprivate func makeLines(sides: BorderSides, width: CGFloat) -> [(start: CGPoint, end: CGPoint)] {
        let shift = width / 2
        var lines = [(start: CGPoint, end: CGPoint)]()
        if sides.contains(.top) {
            lines.append((start: CGPoint(x: 0, y: shift), end: CGPoint(x: bounds.size.width, y: shift)))
        }
        if sides.contains(.right) {
            lines.append((start: CGPoint(x: bounds.size.width - shift, y: 0), end: CGPoint(x: bounds.size.width - shift, y: bounds.size.height)))
        }
        if sides.contains(.bottom) {
            lines.append((start: CGPoint(x: 0, y: bounds.size.height - shift), end: CGPoint(x: bounds.size.width, y: bounds.size.height - shift)))
        }
        if sides.contains(.left) {
            lines.append((start: CGPoint(x: shift, y: 0), end: CGPoint(x: shift, y: bounds.size.height)))
        }
        return lines
    }
}

//MARK: - Corner radius
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

//public extension CornerDesignable where Self: UICollectionViewCell {
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
//}

//MARK: - UIView - corner radius -
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

//MARK: - UIView - corner radius -
public typealias CustomMaskProvider = (CGSize) -> UIBezierPath
public enum MaskType {
    /// For circle shape with diameter equals to min(width, height).
    case circle
    /// For polygon shape with `n` sides. (min: 3, the default: 6).
    case polygon(sides: Int)
    /// For star shape with n points (min: 3, default: 5)
    case star(points: Int)
    /// For isosceles triangle shape. The triangle's height is equal to the view's frame height. If the view is a square, the triangle is equilateral.
    case triangle
    /// For wave shape with `direction` (up or down, default: up), width (default: 40) and offset (default: 0)
    case wave(direction: WaveDirection, width: Double, offset: Double)
    ///  For parallelogram shape with an angle (default: 60). If `angle == 90` then it is a rectangular mask. If `angle < 90` then is a left-oriented parallelogram\-\
    case parallelogram(angle: Double)
    
    /// Custom shape
    case custom(pathProvider: CustomMaskProvider)
    
    case none
    
    /**
     Wave direction for `wave` shape.
     */
    public enum WaveDirection: String {
        /// For the wave facing up.
        case up
        /// For the wave facing down.
        case down
    }
}


//MARK: - CALayer -
extension CALayer {
    
}

//MARK: - Button -
public extension UIButton {
    @discardableResult
    public func text(_ t: String) -> Self {
        setTitle(t, for: UIControlState())
        return self
    }
    
    /**
     Shortcut for `text = NSLocalizedString("X", comment: "")`
     */
    @discardableResult
    public func text(byKey key: String) -> Self {
        text(NSLocalizedString(key, comment: ""))
        return self
    }
    
    @discardableResult
    public func image(_ name: String) -> Self {
        setImage(UIImage(named:name), for: UIControlState())
        return self
    }
}

//MARK: - TextField -
public extension UITextField {
    @discardableResult
    public func placeholder(_ text: String) -> Self {
        placeholder = text
        return self
    }
}

//MARK: - Label -
public extension UILabel {
    @discardableResult
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    /**
        Shortcut for `text = NSLocalizedString("X", comment: "")`
     */
    @discardableResult
    public func text(byKey key: String) -> Self {
        text(NSLocalizedString(key, comment: ""))
        return self
    }
}

//MARK: - Image -
extension UIImage {
    static let empty = UIImage()
}

extension UIImageView {
    @discardableResult
    public func image(_ name: String) -> Self {
        image = UIImage(named: name)
        return self
    }
}
