//
//  TableViewDataSource.swift
//  012-Word-Color-Lean-View-Controller-With-UITableView-UICollectionView
//
//  Created by Audrey Li on 4/5/15.
//  Copyright (c) 2015 com.shomigo. All rights reserved.
//

import Foundation
import UIKit

public typealias TableViewCellConfigureBlock = (cell: UITableViewCell, item: AnyObject?) -> ()

public enum TableViewActionType: String {
    case Edit  = "Edit"
    case Save = "Save"
    case More = "More"
    case Favoriate = "Favoriate"
    case Delete = "Delete"
    case DidSelect = "DidSelect"
    case DidDeselect = "DidDeselect"
}

public class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var items: NSArray = []
    var itemIdentifier: String?
    var configureCellBlock: TableViewCellConfigureBlock?
    var cellActionHandler:((item: AnyObject, indexPath: NSIndexPath, action: TableViewActionType) -> Void)!
    var cellActionList = ["Save", "Favoriate", "Delete"]
    
    public init(items: NSArray, cellIdentifier: String, cellActionHandler: ((item: AnyObject, indexPath: NSIndexPath, action: TableViewActionType) -> Void)!, configureBlock: TableViewCellConfigureBlock){
        self.items = items
        self.itemIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        self.cellActionHandler = cellActionHandler
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.itemIdentifier!, forIndexPath: indexPath) as! UITableViewCell
        let item: AnyObject = itemAtIndexPath(indexPath)
        
        if (self.configureCellBlock != nil) {
            self.configureCellBlock!(cell: cell, item: item)
        }
        
        return cell
    }
   public func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return self.items[indexPath.row]
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cellActionHandler?(item: items[indexPath.row],indexPath: indexPath, action: .DidSelect)
    }
    
    public func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        cellActionHandler?(item: items[indexPath.row], indexPath: indexPath, action: .DidDeselect)
    }
   
    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            cellActionHandler?(item: items[indexPath.row], indexPath: indexPath, action: .Delete)
        }
    }
    
    public func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let favAction =  UITableViewRowAction(style: .Normal, title: "Fav") { (act, indexPath1) -> Void in
            println("") // somehow must add the line to make it work.
            self.cellActionHandler?(item: self.items[indexPath.row],indexPath: indexPath, action: .Favoriate)
        }
        let deleteAction =  UITableViewRowAction(style: .Default, title: "Delete") { (act, indexPath1) -> Void in
            println("")
            self.cellActionHandler?(item: self.items[indexPath.row], indexPath: indexPath, action: .Delete)
        }
        let saveAction =  UITableViewRowAction(style: .Normal, title: "Save") { (act, indexPath1) -> Void in
            println("")
            self.cellActionHandler?(item: self.items[indexPath.row], indexPath: indexPath, action: .Save)
        }
        saveAction.backgroundColor = UIColor.greenColor()
        favAction.backgroundColor = UIColor.orangeColor()
        var returnActions:[AnyObject] = []
        if cellActionList.containsElement("Save") {returnActions.append(saveAction)}
        if cellActionList.containsElement("Favoriate") {returnActions.append(favAction)}
        if cellActionList.containsElement("Delete") {returnActions.append(deleteAction)}
        
        return returnActions
    }
    
    
}
    