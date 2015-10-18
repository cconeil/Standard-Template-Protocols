//
//  ForceTouchGestureRecognizer.swift
//  STP
//
//  Created by Chris O'Neil on 10/18/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

@available(iOS 9.0, *)
class ForceTouchGestureRecognizer: UIGestureRecognizer {

    var force:CGFloat = 0.0

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        self.state = .Began
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)

        if self.state == .Failed {
            return
        }

        let touch = touches.first
        self.force = touch?.force ?? 0.0
        self.state = .Changed
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        self.state = .Ended
    }

    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesCancelled(touches, withEvent: event)
        self.state = .Cancelled
    }
}
