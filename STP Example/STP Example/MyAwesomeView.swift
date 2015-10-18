//
//  MyAwesomeView.swift
//  STP Example
//
//  Created by Chris O'Neil on 10/12/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit
import STP

class MyAwesomeView: UIView, Moveable, Pinchable, Rotatable, Tappable {
    
}

class ForceView: UIView, Forceable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeForceable()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
