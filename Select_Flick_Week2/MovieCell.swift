//
//  MovieCell.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/2/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import UIKit
import MGSwipeTableCell
protocol LikeMovieCellDelegate {
    func clickLikeButton(cellController: MGSwipeTableCell, movie: Movie, isLike:Bool)

}
class MovieCell: MGSwipeTableCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var rating: UILabel!
    var isLike:Bool = false
    var movie:Movie!
    var delegateClick: LikeMovieCellDelegate!
    
    override func prepareForReuse() {
        poster.image = nil
    }
    @IBOutlet weak var likeBtn: UIButton!
    @IBAction func clickLike(sender: AnyObject) {
        if isLike == false {
            likeBtn.setBackgroundImage(UIImage(named: "heart_true"), forState: UIControlState.Normal)
        } else {
            likeBtn.setImage(nil, forState: UIControlState.Normal)
        }
        isLike = !isLike
        delegateClick?.clickLikeButton(self, movie: self.movie, isLike: isLike)
    }
}
