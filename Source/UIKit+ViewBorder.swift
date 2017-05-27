//
//  UIKit+ViewBorder.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/27/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

//MARK: Public API -
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
            applyBorder(on: mask, color: color, width: width)
        } else {
            drawBorders(type: type, sides: sides, color: color, width: width)
        }
        
        return self
    }
    
}

//MARK: - Helpers -
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

//MARK: - Private API -
extension UIView {
    fileprivate func clearLayer() {
        layer.borderColor = nil
        layer.borderWidth = 0
        layer.sublayers?
            .filter { $0.name == "borderSideLayer" || $0.name == "borderAllSides" }
            .forEach { $0.removeFromSuperlayer() }
    }
    
    fileprivate func applyBorder(on mask: CAShapeLayer, color: UIColor?, width: CGFloat) {
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
            drawSides(type: type, sides: sides, color: color, width: width)
        }
    }
    
    fileprivate func drawSides(type: BorderType, sides: BorderSides, color: UIColor?, width: CGFloat) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "borderSideLayer"
        shapeLayer.path = makePath(sides: sides, width: width).cgPath
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
    
    fileprivate func makePath(sides: BorderSides, width: CGFloat) -> UIBezierPath {
        let lines = makeLines(sides: sides, width: width)
        let path = UIBezierPath()
        lines.forEach {
            path.move(to: $0.start)
            path.addLine(to: $0.end)
        }
        return path
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
