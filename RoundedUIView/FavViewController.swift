//
//  FavViewController.swift
//  RoundedUIView
//
//  Created by Audrey Li on 4/28/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

class FavViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var shots:[Shot]!{
        didSet {
            if tableView != nil  && dataSource != nil {
                dataSource?.items = shots
                tableView.reloadData()
            }
        }
    }
    
    var favDoneHandler:((favShots:[Shot]) -> Void)!
    
    var dataSource: TableViewDataSource!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cellActionHandler = {(item: AnyObject, indexPath: NSIndexPath, action: TableViewActionType) -> Void in
            self.tableViewCellActionHandler(item, indexPath: indexPath, action: action)
        }
        
        dataSource = TableViewDataSource(items: shots, cellIdentifier: "cell",cellActionHandler: cellActionHandler, configureBlock: { (cell, item) -> () in
            if let actualCell: ShotTableViewCell = cell as? ShotTableViewCell{
                actualCell.configureForItem(item)
            }
        })
        dataSource.cellActionList = ["Save", "Delete"]
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.allowsMultipleSelection = false
        
    }
    func tableViewCellActionHandler(item: AnyObject, indexPath: NSIndexPath, action: TableViewActionType) {
        switch action {
        case .Edit:
            println("editing")
        case .Favoriate:
            // do nothing as the action is not included
            tableView.setEditing(false, animated: true)
            
        case .Save:
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? ShotTableViewCell {
                if let image = cell.shotImageView?.image {
                    Utils.saveImageToLibrary(image)
                    tableView.setEditing(false, animated: true) // imp
                }
            }
            
        case .DidSelect:
            println("selecting \(indexPath.row)")
        case .DidDeselect:
            tableView.deselectRowAtIndexPath(indexPath, animated: true) // call it to make sure it does deselect. (Sometime, it does)
            println("deselected \(indexPath.row)")
            
        case .Delete:
            shots.removeAtIndex(indexPath.row)
        case .More:
            println("More")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        favDoneHandler?(favShots: shots)
    }
    

}
