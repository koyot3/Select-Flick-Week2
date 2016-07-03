//
//  MovieDetailViewController.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/3/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var Overview: UILabel!
    var movie:Movie?
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = movie!.originalTitle
    }
}
