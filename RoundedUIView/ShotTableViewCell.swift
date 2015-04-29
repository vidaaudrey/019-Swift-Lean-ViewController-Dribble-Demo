//
//  ShotTableViewCell.swift
//  RoundedUIView
//
//  Created by Audrey Li on 4/28/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

class ShotTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var shotImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var numbersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.round()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor(hex: "E91E63")
        } else {
            contentView.backgroundColor = UIColor.blackColor()
        }
        
//        if selected {
//            let topColor = UIColor(hex: "#212121")
//            let bottomColor = UIColor(hex: "#424242")
//            contentView.addGradientBackground(topColor: topColor, bottomColor: bottomColor)
//        } else {
//            if let layer: CAGradientLayer = contentView.layer.sublayers[0] as? CAGradientLayer {
//                contentView.layer.sublayers.removeAtIndex(0)
//            }
//        }
     
    }
    override func prepareForReuse() {

//        if let layer: CAGradientLayer = contentView.layer.sublayers[0] as? CAGradientLayer {
//            contentView.layer.sublayers.removeAtIndex(0)
//        }
        
    }
    
    func configureForItem(item:AnyObject?){
        if let shot:Shot = item as? Shot {
            titleLabel.text = shot.title
            subTitleLabel.text = "by \(shot.user.name)"
            numbersLabel.text = "◉\(shot.viewsCount)  ❤︎\(shot.likesCount)  ⦿\(shot.commentCount)"
            Utils.asyncLoadImageFromURL(shot.imageUrl, imageView: shotImageView)
            Utils.asyncLoadImageFromURL(shot.user.avatarUrl, imageView: userImageView)
            
        }
    }

}
