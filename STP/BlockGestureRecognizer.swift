//
//  BlockGestureRecognizer.swift
//  STP
//
//  Created by Chris O'Neil on 10/11/15.
//  Copyright © 2015 Because. All rights reserved.
//

extension UIGestureRecognizer {

    struct PropertyKeys {
        static var blockKey = "BCBlockPropertyKey"
        static var multipleGestureRecognizerKey = "BCMultipleGestureRecognizerKey"
    }

    private var block:((recognizer:UIGestureRecognizer) -> Void) {
        get {
            return Associator.getAssociatedObject(self, associativeKey:&PropertyKeys.blockKey)!
        }
        set {
            Associator.setAssociatedObject(self, value: newValue, associativeKey:&PropertyKeys.blockKey, policy: .OBJC_ASSOCIATION_RETAIN)
        }
    }

    convenience init(block:(recognizer:UIGestureRecognizer) -> Void) {
        self.init()
        self.block = block
        self.addTarget(self, action: "didInteractWithGestureRecognizer:")
    }

    @objc func didInteractWithGestureRecognizer(sender:UIGestureRecognizer) {
        self.block(recognizer: sender)
    }
}
