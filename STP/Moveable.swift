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
    func translateToPointFromTranslation(translation:CGPoint, velocity:CGPoint, startPoint:CGPoint, currentPoint:CGPoint) -> CGPoint
    func animateToPoint(point:CGPoint)
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
                startPoint = pan.view?.center ?? CGPointZero
                self.didStartMoving()
            case .Ended, .Cancelled, .Failed:
                self.didFinishMoving(velocity)
            default:
                let point = self.translateToPointFromTranslation(translation, velocity:velocity, startPoint: startPoint, currentPoint: currentPoint)
                currentPoint = point
                self.animateToPoint(point)
            }
        }
        self.addGestureRecognizer(gestureRecognizer)
    }

    func animateToPoint(point:CGPoint) {
        UIView.animateWithDuration(0.01) { () -> Void in
            self.center = point
        }
    }

    func translateToPointFromTranslation(translation:CGPoint, velocity:CGPoint, startPoint:CGPoint, currentPoint:CGPoint) -> CGPoint {
        var point = startPoint

        if (self.canMoveToX(translation.x)) {
            point.x += translation.x
        }

        if (self.canMoveToY(translation.x)) {
            point.y += translation.y
        }

        return point
    }

    func didStartMoving() {
        return
    }

    func didFinishMoving(velocity:CGPoint) {
        return
    }

    func canMoveToX(x:CGFloat) -> Bool {
        return true
    }

    func canMoveToY(y:CGFloat) -> Bool {
        return true
    }
}
