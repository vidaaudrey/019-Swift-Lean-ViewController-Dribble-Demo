//
//  ViewController.swift
//  RoundedUIView
//
//  Created by Audrey Li on 4/28/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    let customNavigationAnimationController = CustomNavigationAnimationController()
    let customInteractionController = CustomInteractionController()
    var isVerticalTransition = false
    var isToViewRight = false
    //var isToViewBottom = false
    
    var shots:[Shot] = [Shot]() {
        didSet {
            dataSource?.items = shots
            tableView.reloadData()
        }
    }
    
    var favShots:[Shot] = []
    var dataSource: TableViewDataSource!
    var dvcData: UIImage!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        customNavigationAnimationController.isVerticalTransition = isVerticalTransition
        customNavigationAnimationController.isToViewRight = isToViewRight
        customInteractionController.isVerticalTransition = isVerticalTransition
        customInteractionController.isToViewRight = isToViewRight
        
        activityIndicator.startAnimating()
        let url = Config.SHOT_URL + Config.ACCESS_TOKEN
        DribbleObjectHandler.getShots(Config.SHOT_URL, callback: { (shots) -> Void in
            self.shots = shots
            self.activityIndicator.stopAnimating()
        })
        
        var cellActionHandler = {(item: AnyObject, indexPath: NSIndexPath, action: TableViewActionType) -> Void in
            self.tableViewCellActionHandler(item, indexPath: indexPath, action: action)
        }
        
        dataSource = TableViewDataSource(items: shots, cellIdentifier: "cell",cellActionHandler: cellActionHandler, configureBlock: { (cell, item) -> () in
            if let actualCell: ShotTableViewCell = cell as? ShotTableViewCell{
                actualCell.configureForItem(item)
            }
        })
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.allowsMultipleSelection = false
       
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        customNavigationAnimationController.reverse = operation == .Pop
        
        if operation == .Push {
            customInteractionController.attachToViewController(toVC)
        }
        return customNavigationAnimationController
    }
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return customInteractionController.transitionInProgress ? customInteractionController : nil
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dvc = segue.destinationViewController as? FavViewController {
            dvc.shots = favShots.unique()
            dvc.favDoneHandler = {(favShots:[Shot]) -> Void in
                self.favShots = favShots   // update the favShots data as the user might delete some 
            }
        }
        if let dvc = segue.destinationViewController as? SingleShotImageViewController {
            dvc.image = dvcData
        }
    }
    
    func tableViewCellActionHandler(item: AnyObject, indexPath: NSIndexPath, action: TableViewActionType) {
        switch action {
        case .Edit:
            println("editing")
        case .Favoriate:
            favShots.append(item as! Shot)
            println("faved")
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
    

    @IBAction func swipeRightToView(sender: UISwipeGestureRecognizer) {
        let touchPoint = sender.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(touchPoint)
        if indexPath != nil {
            if let cell: ShotTableViewCell = tableView.cellForRowAtIndexPath(indexPath!) as? ShotTableViewCell {
                if let image = cell.shotImageView?.image {
                    dvcData = image
                }
            }
            performSegueWithIdentifier("showShotImage", sender: self)
        }

    }
    
}

