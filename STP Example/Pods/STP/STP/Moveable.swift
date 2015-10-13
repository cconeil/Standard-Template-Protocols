//
//  Moveable.swift
//  Standard Template Categories
//
//  Created by Chris O'Neil on 9/20/15.
//  Copyright (c) 2015 Because. All rights reserved.
//

import UIKit

public protocol Moveable {
    func makeMoveable()
    func didStartMoving()
    func didFinishMoving()
    func translateToPointFromTranslation(translation:CGPoint, startPoint:CGPoint, currentPoint:CGPoint) -> CGPoint
    func animateToPoint(point:CGPoint)
}

public extension Moveable where Self:UIView {

    func makeMoveable() {

        var startPoint:CGPoint = CGPointZero
        var currentPoint:CGPoint = CGPointZero

        let gestureRecognizer = UIPanGestureRecognizer { [unowned self] (recognizer) -> Void in
            let pan = recognizer as! UIPanGestureRecognizer
            let translation = pan.translationInView(self.superview)
            switch recognizer.state {
            case .Began:
                startPoint = pan.view?.center ?? CGPointZero
                self.didStartMoving()
            case .Ended, .Cancelled, .Failed:
                self.didFinishMoving()
            default:
                let point = self.translateToPointFromTranslation(translation, startPoint: startPoint, currentPoint: currentPoint)
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

    func translateToPointFromTranslation(translation:CGPoint, startPoint:CGPoint, currentPoint:CGPoint) -> CGPoint {
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

    func didFinishMoving() {
        return
    }

    func canMoveToX(x:CGFloat) -> Bool {
        return true
    }

    func canMoveToY(y:CGFloat) -> Bool {
        return true
    }
}
