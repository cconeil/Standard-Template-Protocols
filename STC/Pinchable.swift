//
//  Pinchable.swift
//  Standard Template Categories
//
//  Created by Chris O'Neil on 10/6/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit

public protocol Pinchable {
    func makePinchable()
    func didStartPinching()
    func didFinishPinching()
    func transformWithScale(scale:CGFloat, lastScale:CGFloat) -> CGAffineTransform
    func animateToPinchedTransform(transform:CGAffineTransform)
}

public extension Pinchable where Self:UIView {

    func makePinchable() {

        var lastScale:CGFloat = 1.0
        // [unowned self, unowned pinchState]
        let gestureRecognizer = UIPinchGestureRecognizer { (recognizer) -> Void in
            let pinch = recognizer as! UIPinchGestureRecognizer
            switch pinch.state {
            case .Began:
                self.didStartPinching()
            case .Ended:
                self.didFinishPinching()
                lastScale = 1.0
            case .Changed:
                let scale = pinch.scale
                let transform = self.transformWithScale(scale, lastScale: lastScale)
                lastScale = scale
                self.animateToPinchedTransform(transform)
            default:
                break
            }
        }
        self.addGestureRecognizer(gestureRecognizer)
    }

    func didStartPinching() {
        return
    }

    func didFinishPinching() {
        return
    }

    func maximumPinchScale() -> CGFloat {
        return 2.0
    }

    func minimumPinchScale() -> CGFloat {
        return 0.1
    }

    func transformWithScale(scale:CGFloat, lastScale:CGFloat) -> CGAffineTransform {
        let updatedScale = 1.0 - (lastScale - scale)
        return CGAffineTransformScale(self.transform, updatedScale, updatedScale)
    }

    func animateToPinchedTransform(transform:CGAffineTransform) {
        UIView.animateWithDuration(0.01) { () -> Void in
            self.transform = transform
        }
    }
}
