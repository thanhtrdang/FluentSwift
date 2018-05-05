//
//  UIKit+ViewMask.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/27/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

// MARK: Public API -

extension UIView {
  @discardableResult
  public func mask(type: MaskType, previousType: MaskType = .none) -> Self {
    switch type {
    case .circle:
      maskCircle()
    case let .parallelogram(angle):
      maskParallelogram(with: angle)
    case let .polygon(sides):
      maskPolygon(with: sides)
    case let .star(points):
      maskStar(with: points)
    case let .wave(direction, width, offset):
      maskWave(with: direction, width: width, offset: offset)
    case .triangle:
      maskTriangle()
    case let .custom(pathProvider):
      maskCustom(with: pathProvider)
    case .none:
      // If `previousMaskType` is `.none`, then we will **not** remove `layer.mask` before re-adding it.
      // This allows for custom masks to be preserved.
      if previousType != .none {
        layer.mask?.removeFromSuperlayer()
      }
    }

    return self
  }
}

// MARK: - Helpers -

public typealias CustomMaskProvider = (CGSize) -> UIBezierPath
public enum MaskType {
  /// For circle shape with diameter equals to min(width, height).
  case circle
  /// For polygon shape with `n` sides. (min: 3, the default: 6).
  case polygon(sides: Int)
  /// For star shape with n points (min: 3, default: 5)
  case star(points: Int)
  /// For isosceles triangle shape.
  /// The triangle's height is equal to the view's frame height.
  /// If the view is a square, the triangle is equilateral.
  case triangle
  /// For wave shape with `direction` (up or down, default: up), width (default: 40) and offset (default: 0)
  case wave(direction: WaveDirection, width: Double, offset: Double)
  /// For parallelogram shape with an angle (default: 60).
  /// If `angle == 90` then it is a rectangular mask. If `angle < 90` then is a left-oriented parallelogram\-\
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

// TODO: Just focus on .none, improve others later
extension MaskType: Equatable {
  public static func == (lhs: MaskType, rhs: MaskType) -> Bool {
    switch (lhs, rhs) {
    case (.circle, .circle):
      return true
    //        case (.polygon, .polygon):
    //            return true
    //        case (.star, .star):
    //            return true
    case (.triangle, .triangle):
      return true
    //        case (.wave, .wave):
    //            return true
    //        case (.parallelogram, .parallelogram):
    //            return true
    //        case (.custom, .custom):
    //            return true
    case (.none, .none):
      return true
    default:
      return false
    }
  }
}

// MARK: - Private API -

extension UIView {
  fileprivate func maskCircle() {
    let diameter = ceil(min(bounds.width, bounds.height))
    let origin = CGPoint(x: (bounds.width - diameter) / 2.0, y: (bounds.height - diameter) / 2.0)
    let size = CGSize(width: diameter, height: diameter)
    let circlePath = UIBezierPath(ovalIn: CGRect(origin: origin, size: size))
    draw(circlePath)
  }

  fileprivate func maskPolygon(with sides: Int) {
    let polygonPath = createPolygonPath(with: max(sides, 3))
    draw(polygonPath)
  }

  fileprivate func createPolygonPath(with sides: Int) -> UIBezierPath {
    let path = UIBezierPath()
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle: CGFloat = -.pi / 2
    let angleIncrement = .pi * 2 / CGFloat(sides)
    let length = min(bounds.width, bounds.height)
    let radius = length / 2.0

    path.move(to: point(from: angle, radius: radius, offset: center))
    for _ in 1 ... sides - 1 {
      angle += angleIncrement
      path.addLine(to: point(from: angle, radius: radius, offset: center))
    }
    path.close()
    return path
  }

  fileprivate func maskStar(with points: Int) {
    // FIXME: Do not mask the shadow.

    // Stars must has at least 3 points.
    var starPoints = points
    if points <= 2 {
      starPoints = 5
    }

    let path = createStarPath(with: starPoints)
    draw(path)
  }

  fileprivate func createStarPath(with points: Int, borderWidth: CGFloat = 0) -> UIBezierPath {
    let path = UIBezierPath()
    let radius = min(bounds.size.width, bounds.size.height) / 2 - borderWidth
    let starExtrusion = radius / 2
    let angleIncrement = .pi * 2 / CGFloat(points)
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle: CGFloat = -.pi / 2
    for _ in 1 ... points {
      let aPoint = point(from: angle, radius: radius, offset: center)
      let nextPoint = point(from: angle + angleIncrement, radius: radius, offset: center)
      let midPoint = point(from: angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)

      if path.isEmpty {
        path.move(to: aPoint)
      }

      path.addLine(to: midPoint)
      path.addLine(to: nextPoint)
      angle += angleIncrement
    }

    path.close()
    return path
  }

  fileprivate func maskParallelogram(with topLeftAngle: Double) {
    let parallelogramPath = createParallelogramPath(with: topLeftAngle)
    draw(parallelogramPath)
  }

  fileprivate func createParallelogramPath(with topLeftAngle: Double) -> UIBezierPath {
    let topLeftAngleRad = topLeftAngle * .pi / 180
    let path = UIBezierPath()
    let offset = abs(CGFloat(tan(topLeftAngleRad - .pi / 2)) * bounds.height)

    if topLeftAngle <= 90 {
      path.move(to: CGPoint(x: 0, y: 0))
      path.addLine(to: CGPoint(x: bounds.width - offset, y: 0))
      path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
      path.addLine(to: CGPoint(x: offset, y: bounds.height))
    } else {
      path.move(to: CGPoint(x: offset, y: 0))
      path.addLine(to: CGPoint(x: bounds.width, y: 0))
      path.addLine(to: CGPoint(x: bounds.width - offset, y: bounds.height))
      path.addLine(to: CGPoint(x: 0, y: bounds.height))
    }
    path.close()
    return path
  }

  fileprivate func maskTriangle() {
    let trianglePath = createTrianglePath()
    draw(trianglePath)
  }

  fileprivate func createTrianglePath() -> UIBezierPath {
    let path = UIBezierPath()

    path.move(to: CGPoint(x: bounds.width / 2.0, y: bounds.origin.y))
    path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
    path.addLine(to: CGPoint(x: bounds.origin.x, y: bounds.height))
    path.close()

    return path
  }

  fileprivate func maskWave(with direction: MaskType.WaveDirection, width: Double, offset: Double) {
    let wavePath = createWavePath(with: direction == .up, width: CGFloat(width), offset: CGFloat(offset))
    draw(wavePath)
  }

  fileprivate func createWavePath(with isUp: Bool, width: CGFloat, offset: CGFloat) -> UIBezierPath {
    let originY = isUp ? bounds.maxY : bounds.minY
    let halfWidth = width / 2.0
    let halfHeight = bounds.height / 2.0
    let quarterWidth = width / 4.0

    var isUp = isUp
    var startX = bounds.minX - quarterWidth - (offset.truncatingRemainder(dividingBy: width))
    var endX = startX + halfWidth

    let path = UIBezierPath()
    path.move(to: CGPoint(x: startX, y: originY))
    path.addLine(to: CGPoint(x: startX, y: bounds.midY))

    repeat {
      path.addQuadCurve(
        to: CGPoint(x: endX, y: bounds.midY),
        controlPoint: CGPoint(
          x: startX + quarterWidth,
          y: isUp ? bounds.maxY + halfHeight : bounds.minY - halfHeight)
      )
      startX = endX
      endX += halfWidth
      isUp = !isUp
    } while startX < bounds.maxX

    path.addLine(to: CGPoint(x: path.currentPoint.x, y: originY))
    return path
  }

  fileprivate func maskCustom(with provider: CustomMaskProvider) {
    draw(provider(bounds.size))
  }

  fileprivate func draw(_ path: UIBezierPath) {
    layer.mask?.removeFromSuperlayer()

    let maskLayer = CAShapeLayer()
    maskLayer.frame = CGRect(origin: .zero, size: bounds.size)
    maskLayer.path = path.cgPath
    layer.mask = maskLayer
  }

  fileprivate func degree2radian(degree: CGFloat) -> CGFloat {
    return .pi * degree / 180
  }

  fileprivate func point(from angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
    return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
  }
}
