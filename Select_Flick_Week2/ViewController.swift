//
//  ViewController.swift
//  Select_Flick_Week2
//
//  Created by admin on 6/30/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let movieService = MovieDbService()
    var movies:[Movie] = []
    var pageNumber = 0
    @IBOutlet var movieTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        loadMovies()
        // add new search bar
        var searchBar = UISearchBar()
        searchBar.sizeToFit()
        self.navigationItem.titleView = searchBar
    }
    
    func loadMovies(){
        pageNumber = pageNumber + 1
            movieService.getLatestMovies() { responseObject, error in
                guard let tempData = responseObject else { print("There's nothing there"); return }
                let jsonMovies = tempData.valueForKeyPath("results") as! [NSDictionary]
                for jsonMovie in jsonMovies{
                    let movie = Movie(rawData: jsonMovie)
                    self.movies.append(movie)
                }
                self.movieTableView.reloadData()
            }
    }
    
    
    func resetMovies(){
        self.movies = []
    }
}

extension ViewController : UITableViewDelegate {
    
}

extension ViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        cell.nameLabel.text = movie.originalTitle
        cell.yearLabel.text = movie.releaseDate[movie.releaseDate.startIndex.advancedBy(0)...movie.releaseDate.startIndex.advancedBy(3)]
        
        movieService.getMoviePoster(movie.posterPath){ responseObject, error in
            guard let tempData = responseObject else { print("There's nothing there"); return }
            cell.poster.image = UIImage(data: tempData)
        }
        
        movieService.getMoviePoster(movie.backDrop){ responseObject, error in
            guard let tempData = responseObject else { print("There's nothing there"); return }
            cell.backDropImage.image = UIImage(data: tempData)
        }
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "ShowMovieDetailSegue",
            let destination = segue.destinationViewController as? MovieDetailViewController,
            blogIndex = movieTableView.indexPathForSelectedRow?.row
        {
            destination.movie = movies[blogIndex]
        }
    }
}

