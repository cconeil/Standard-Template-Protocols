//
//  HomeViewController.swift
//  STP Example
//
//  Created by Chris O'Neil on 10/22/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit

enum GestureRecognizerType:Int {
    case Moveable
    case Pinchable
    case Rotatable
    case Tappable
    case Forceable

    func name() -> String {
        switch self {
        case .Moveable:
            return "Moveable"
        case .Pinchable:
            return "Pinchable"
        case .Rotatable:
            return "Rotatable"
        case .Tappable:
            return "Tappable"
        case .Forceable:
            return "Forceable"
        }
    }
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    let cellIdentifier = "HomeTableViewCellIdentifier"
    let headerFooterIdentifier = "HomeTableViewHeaderFooterViewIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Choose a Gesture Protocol"

        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsMultipleSelection = true
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()

        let nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "didTapNext:")
        self.navigationItem.rightBarButtonItem = nextButton
     }

    // MARK: UITableViewDataSource

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellIdentifier)
        }
        cell!.textLabel?.text = GestureRecognizerType(rawValue: indexPath.row)?.name()
        cell!.selectionStyle = .None;
        return cell!
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)
        tableViewCell?.accessoryType = .Checkmark
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let tableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)
        tableViewCell?.accessoryType = .None
    }

    func didTapNext(sender:UIBarButtonItem) {
        guard let selectedRows = self.tableView.indexPathsForSelectedRows else {
            return
        }

        let types:[GestureRecognizerType] = selectedRows.map {
            GestureRecognizerType(rawValue: $0.row)!
        }
        let awesomeViewController = AwesomeViewController(types: types)
        self.navigationController?.pushViewController(awesomeViewController, animated: true)
    }
}
