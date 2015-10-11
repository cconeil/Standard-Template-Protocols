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

public extension Rotatable where Self:UIView {

    func makeRotatable() {
        var lastRotation:CGFloat = 0.0
        let gestureRecognizer = UIRotationGestureRecognizer { (recognizer) -> Void in
            let rotation = recognizer as! UIRotationGestureRecognizer
            switch rotation.state {
            case .Began:
                self.didStartRotating()
                lastRotation = 0.0
            case .Ended:
                self.didFinishRotating()
            case .Changed:
                let transform = self.transformWithRotation(rotation.rotation, lastRotation: lastRotation)
                self.animateToRotatedTransform(transform)
                lastRotation = rotation.rotation
            default:
                break
            }
        }
        self.addGestureRecognizer(gestureRecognizer)
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
