//
//  MovieCell.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/2/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import UIKit
import StarReview
class MovieCell: UITableViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func prepareForReuse() {
        poster.image = nil
    }
}
