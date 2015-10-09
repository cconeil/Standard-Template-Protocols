//
//  Rotatable.swift
//  Standard Template Categories
//
//  Created by Chris O'Neil on 10/6/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit

public protocol Rotatable {
    func makeRotatable()
    func didStartRotating()
    func didFinishRotating()

    func transformWithRotation(rotation:CGFloat, lastRotation:CGFloat) -> CGAffineTransform
    func animateToRotatedTransform(transform:CGAffineTransform)
}

public class RotatationState {
    var lastRotation:CGFloat = 0.0
    var rotationHandler:((rotation:UIRotationGestureRecognizer) -> Void)?

    @objc func didRotate(rotation:UIRotationGestureRecognizer) {
        if let block = self.rotationHandler {
            block(rotation: rotation)
        }
    }
}

public extension Rotatable where Self:UIView {

    func makeRotatable() {
        let rotationState = RotatationState()
        let rotation = UIRotationGestureRecognizer(target: rotationState, action: "didRotate:")
        self.addGestureRecognizer(rotation)

        func resetLastRotation() {
            rotationState.lastRotation = 0.0
        }

        rotationState.rotationHandler = {
            [unowned self, unowned rotationState] (rotation:UIRotationGestureRecognizer) in

            switch rotation.state {
            case .Began:
                self.didStartRotating()
                resetLastRotation()
            case .Ended:
                self.didFinishRotating()
            case .Changed:
                let transform = self.transformWithRotation(rotation.rotation, lastRotation: rotationState.lastRotation)
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
