//
//  Moveable.swift
//  Standard Template Protocols
//
//  Created by Chris O'Neil on 9/20/15.
//  Copyright (c) 2015 Because. All rights reserved.
//

import UIKit

public protocol Moveable {
    func makeMoveable()
    func didStartMoving()
    func didFinishMoving(velocity:CGPoint)
    func canMoveToX(x:CGFloat) -> Bool
    func canMoveToY(y:CGFloat) -> Bool
    func translateCenter(translation:CGPoint, velocity:CGPoint, startPoint:CGPoint, currentPoint:CGPoint) -> CGPoint
    func animateToMovedTransform(transform:CGAffineTransform)
}

public extension Moveable where Self:UIView {

    func makeMoveable() {

        var startPoint:CGPoint = CGPointZero
        var currentPoint:CGPoint = CGPointZero

        let gestureRecognizer = UIPanGestureRecognizer { [unowned self] (recognizer) -> Void in
            let pan = recognizer as! UIPanGestureRecognizer
            let velocity = pan.velocityInView(self.superview)
            let translation = pan.translationInView(self.superview)
            switch recognizer.state {
            case .Began:
                startPoint = self.center
                currentPoint = self.center
                self.didStartMoving()
            case .Ended, .Cancelled, .Failed:
                self.didFinishMoving(velocity)
            default:
                let point = self.translateCenter(translation, velocity:velocity, startPoint: startPoint, currentPoint: currentPoint)
                self.animateToMovedTransform(self.transformFromCenter(point, currentPoint: currentPoint))
                currentPoint = point
            }
        }
        self.addGestureRecognizer(gestureRecognizer)
    }

    func animateToMovedTransform(transform:CGAffineTransform) {
        UIView.animateWithDuration(0.01) { () -> Void in
            self.transform = transform;
        }
    }

    func translateCenter(translation:CGPoint, velocity:CGPoint, startPoint:CGPoint, currentPoint:CGPoint) -> CGPoint {
        var point = startPoint

        if (self.canMoveToX(point.x + translation.x)) {
            point.x += translation.x
        } else {
            point.x = translation.x > 0.0 ? maximumPoint().x : minimumPoint().x
        }

        if (self.canMoveToY(point.y + translation.y)) {
            point.y += translation.y
        } else {
            point.y = translation.y > 0.0 ? maximumPoint().y : minimumPoint().y
        }

        return point
    }

    func transformFromCenter(center:CGPoint, currentPoint:CGPoint) -> CGAffineTransform {
        return CGAffineTransformTranslate(self.transform, center.x - currentPoint.x , center.y - currentPoint.y)
    }

    func didStartMoving() {
        return
    }

    func didFinishMoving(velocity:CGPoint) {
        return
    }

    func canMoveToX(x:CGFloat) -> Bool {
        if let superviewFrame = self.superview?.frame {
            let diameter = self.frame.size.width / 2.0
            if x + diameter > superviewFrame.size.width {
                return false
            }
            if x - diameter < 0.0 {
                return false
            }
        }
        return true
    }

    func canMoveToY(y:CGFloat) -> Bool {
        if let superviewFrame = self.superview?.frame {
            let diameter = self.frame.size.height / 2.0
            if y + diameter > superviewFrame.size.height {
                return false
            }
            if y - diameter < 0.0 {
                return false
            }
        }
        return true
    }

    func maximumPoint() -> CGPoint {
        if let superviewFrame = self.superview?.frame {
            let x = superviewFrame.size.width - self.frame.size.width / 2.0
            let y = superviewFrame.size.height - self.frame.size.height / 2.0
            return CGPointMake(x, y)
        } else {
            return CGPoint.zero
        }
    }

    func minimumPoint() -> CGPoint {
        let x = self.frame.size.width / 2.0
        let y = self.frame.size.height / 2.0
        return CGPointMake(x, y)
    }
}
