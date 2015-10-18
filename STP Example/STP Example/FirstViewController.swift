//
//  FirstViewController.swift
//  STP Example
//
//  Created by Chris O'Neil on 10/12/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit

import STP

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let forceView = ForceView(frame: CGRectMake(0.0, 0.0, 300.0, 300.0))
        forceView.backgroundColor = UIColor.blueColor()
        self.view.addSubview(forceView)

        let awesomeView = MyAwesomeView()
        awesomeView.backgroundColor = UIColor.blueColor()
        awesomeView.frame = CGRectMake(100.0, 100.0, 200.0, 200.0)
        awesomeView.makePinchable()
        awesomeView.makeMoveable()
        awesomeView.makeRotatable()
        awesomeView.makeTappable()
        self.view.addSubview(awesomeView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

