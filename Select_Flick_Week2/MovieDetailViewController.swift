//
//  MovieDetailViewController.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/3/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var Overview: UILabel!
    var movie:Movie?
    let movieService = MovieDbService()
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = movie!.originalTitle
        
        movieService.getMoviePoster(self.movie!.posterPath!, highQuality: false){ responseObject, error in
            guard let tempData = responseObject else { print("There's nothing there"); return }
            self.poster.image = UIImage(data: tempData)
            self.movieService.getMoviePoster(self.movie!.posterPath!, highQuality: true) { responseObject, error in
                guard let tempData = responseObject else { print("There's nothing there"); return }
                self.poster.image = UIImage(data: tempData)
            }
        }
        
        self.releaseDate.text = self.movie!.releaseDate[self.movie!.releaseDate.startIndex.advancedBy(0)...self.movie!.releaseDate.startIndex.advancedBy(3)]
    }
}
