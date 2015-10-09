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

public class MoveState {
    var startPoint:CGPoint = CGPointZero
    var currentPoint:CGPoint = CGPointZero
    var panHandler:((pan:UIPanGestureRecognizer) -> Void)?

    @objc func didPan(pan:UIPanGestureRecognizer) {
        if let block = self.panHandler {
            block(pan: pan)
        }
    }
}

public extension Moveable where Self:UIView {

    func makeMoveable() {
        let moveState = MoveState()
        let pan = UIPanGestureRecognizer(target: moveState, action: "didPan:")
        self.addGestureRecognizer(pan)

        func moveToTranslation(translation:CGPoint) {
            let point = self.translateToPointFromTranslation(translation, startPoint: moveState.startPoint, currentPoint: moveState.currentPoint)
            moveState.currentPoint = point
            self.animateToPoint(point)
        }

        moveState.panHandler = {
            [unowned self, unowned moveState] (pan : UIPanGestureRecognizer) in

            let translation = pan.translationInView(self.superview)
            switch pan.state {
            case .Began:
                moveState.startPoint = pan.view?.center ?? CGPointZero
                self.didStartMoving()
            case .Ended, .Cancelled, .Failed:
                self.didFinishMoving()
            default:
                moveToTranslation(translation)
            }
        }
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
