//
//  ManualTableViewController.swift
//  RoundedUIView
//
//  Created by Audrey Li on 4/28/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

class ManualTableViewController: UIViewController, UITableViewDataSource {
    let cellIdentifier = "cellID"
    let data = ["ab", "cd", "ef"]
    let data1 = ["afewfb", "fewfewcd", "efewfewf"]
    var tableData = [String]()

    let tableViewController = UITableViewController(style: .Plain)
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableData = data
        let tableView = tableViewController.tableView
        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: cellIdentifier)
       
        tableViewController.refreshControl = refreshControl
        tableViewController.tableView.contentOffset = CGPointMake(0, -refreshControl.frame.size.height)
        
        refreshControl.beginRefreshing()
        tableView.dataSource = self
        refreshControl.addTarget(self, action: "didRefresh", forControlEvents: .ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Last updated on \(NSDate())")
        refreshControl.tintColor = UIColor.blueColor()
        view.addSubview(tableView)
        refreshControl.endRefreshing()
        
    }

    
    func didRefresh(){
        tableData = data1
        tableViewController.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }

}
