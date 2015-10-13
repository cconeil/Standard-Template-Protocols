//
//  Rotatable.swift
//  Standard Template Protocols
//
//  Created by Chris O'Neil on 10/6/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit

public protocol Rotatable {
    func makeRotatable()
    func didStartRotating()
    func didFinishRotating(velocity:CGFloat)
    func minimumRotation() -> CGFloat
    func maximumRotation() -> CGFloat
    func transformWithRotation(rotation:CGFloat, lastRotation:CGFloat, velocity:CGFloat) -> CGAffineTransform
    func animateToRotatedTransform(transform:CGAffineTransform)
}

public extension Rotatable where Self:UIView {

    func makeRotatable() {
        var lastRotation:CGFloat = 0.0
        let gestureRecognizer = UIRotationGestureRecognizer { [unowned self] (recognizer) -> Void in
            let rotation = recognizer as! UIRotationGestureRecognizer
            let velocity = rotation.velocity
            switch rotation.state {
            case .Began:
                self.didStartRotating()
                lastRotation = 0.0
            case .Ended:
                self.didFinishRotating(velocity)
            case .Changed:
                let transform = self.transformWithRotation(rotation.rotation, lastRotation: lastRotation, velocity:velocity)
                self.animateToRotatedTransform(transform)
                lastRotation = rotation.rotation
            default:
                break
            }
        }
        self.addGestureRecognizer(gestureRecognizer)
    }

    func transformWithRotation(rotation:CGFloat, lastRotation:CGFloat, velocity:CGFloat) -> CGAffineTransform {
        let angle = rotation - lastRotation
        return CGAffineTransformRotate(self.transform, angle)
    }

    func animateToRotatedTransform(transform:CGAffineTransform) {
        UIView.animateWithDuration(0.0) { () -> Void in
            self.transform = transform
        }
    }

    func minimumRotation() -> CGFloat {
        return CGFloat.max
    }

    func maximumRotation() -> CGFloat {
        return CGFloat.min
    }

    func didStartRotating() {
        return
    }

    func didFinishRotating(velocity:CGFloat) {
        return
    }
}
