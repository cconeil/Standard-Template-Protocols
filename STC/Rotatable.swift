//
//  Rotatable.swift
//  Standard Template Categories
//
//  Created by Chris O'Neil on 10/6/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit

protocol Rotatable {
    func makeRotatable()
    func didStartRotating()
    func didFinishRotating()
    func minimumRotation() -> CGFloat
    func maximumRotation() -> CGFloat

    func transformWithRotation(rotation:CGFloat, lastRotation:CGFloat) -> CGAffineTransform
    func animateToRotatedTransform(transform:CGAffineTransform)
}

class RotatationState {
    var lastRotation:CGFloat = 0.0
    var rotationHandler:((rotation:UIRotationGestureRecognizer) -> Void)?

    @objc func didRotate(rotation:UIRotationGestureRecognizer) {
        if let block = self.rotationHandler {
            block(rotation: rotation)
        }
    }
}

extension Rotatable where Self:UIView {

    func makeRotatable() {
        let rotationState = RotatationState()
        let rotation = UIRotationGestureRecognizer(target: rotationState, action: "didRotate:")
        self.addGestureRecognizer(rotation)

        func getRotation() -> CGFloat {
            let angle = rotation.rotation
            let currentAngle = atan2(self.transform.b, self.transform.a)

            if (angle + currentAngle > maximumRotation()) {
                return self.maximumRotation()
            } else if (angle + currentAngle < maximumRotation()) {
                return self.minimumRotation()
            } else {
                return angle
            }
        }

        rotationState.rotationHandler = {
            [unowned rotationState, unowned self] (rotation:UIRotationGestureRecognizer) in

            switch rotation.state {
            case .Began:
                self.didStartRotating()
                rotationState.lastRotation = 0.0
            case .Ended:
                self.didFinishRotating()
            case .Changed:
                let transform = self.transformWithRotation(getRotation(), lastRotation: rotationState.lastRotation)
                self.animateToRotatedTransform(transform)
                rotationState.lastRotation = rotation.rotation
            default:
                break
            }
        }
    }

    func transformWithRotation(rotation:CGFloat, lastRotation:CGFloat) -> CGAffineTransform {
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

    func didFinishRotating() {
        return
    }
}
