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

public class PinchState {
    var lastScale:CGFloat = 1.0
    var pinchHandler:((pinch:UIPinchGestureRecognizer) -> Void)?

    @objc func didPinch(pinch:UIPinchGestureRecognizer) {
        if let block = self.pinchHandler {
            block(pinch: pinch)
        }
    }
}

public extension Pinchable where Self:UIView {

    func makePinchable() {
        let pinchState = PinchState()
        let pinch = UIPinchGestureRecognizer(target: pinchState, action: "didPinch:")
        self.addGestureRecognizer(pinch)

        pinchState.pinchHandler = {
            /* [unowned pinchState, unowned self] */ (pinch:UIPinchGestureRecognizer) in

            switch pinch.state {
            case .Began:
                self.didStartPinching()
            case .Ended:
                pinchState.lastScale = 1.0
                self.didFinishPinching()
            case .Changed:
                let scale = pinch.scale
                let transform = self.transformWithScale(scale, lastScale: pinchState.lastScale)
                pinchState.lastScale = scale
                self.animateToPinchedTransform(transform)
            default:
                break
            }
        }
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
