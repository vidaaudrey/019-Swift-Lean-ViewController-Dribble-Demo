//
//  SingleShotImageViewController.swift
//  RoundedUIView
//
//  Created by Audrey Li on 4/28/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

class SingleShotImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        if image != nil {
            imageView.image = image
        }
    }

}
