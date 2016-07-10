//
//  ViewController.swift
//  Select_Flick_Week2
//
//  Created by admin on 6/30/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import UIKit
import JGProgressHUD

class ViewController: UIViewController {
    let movieService = MovieDbService()
    var movies:[Movie] = []
    var pageNumber = 0
    var displayCategory = "Now playing"
    var segmentControl:UISegmentedControl!
    var loadingModal:JGProgressHUD!
    var errorModal:JGProgressHUD!
    var searchBar: UISearchBar?
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet var movieTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        setTheme()
        loadMovies()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func enterSearchFilter(sender: AnyObject) {
        
    }
    @IBAction func segmentedControlAction(sender: AnyObject) {
        // HELP HELP HELP
        if(segmentControl.selectedSegmentIndex == 0)
        {
            //textLabel.text = "First Segment Selected";
        }
        else if(segmentControl.selectedSegmentIndex == 1)
        {
            //textLabel.text = "Second Segment Selected";
        }
    }
    
    func loadMovies(){
        pageNumber = pageNumber + 1
        if displayCategory == "Now playing" {
            loadingModal.showInView(self.view)
            movieService.getNowPlayingMovies() { responseObject, error in
                self.loadingModal.dismissAfterDelay(2, animated: true)
                guard let tempData = responseObject else { print("There's nothing there"); return }
                let jsonMovies = tempData.valueForKeyPath("results") as! [NSDictionary]
                for jsonMovie in jsonMovies{
                    let movie = Movie(rawData: jsonMovie)
                    self.movies.append(movie)
                }
                self.movieTableView.reloadData()
                
            }
        } else if displayCategory == "Top Rated" {
            loadingModal.showInView(self.view)
            movieService.getTopRatedMovies() { responseObject, error in
                self.loadingModal.dismissAfterDelay(2, animated: true)
                guard let tempData = responseObject else { print("There's nothing there"); return }
                let jsonMovies = tempData.valueForKeyPath("results") as! [NSDictionary]
                for jsonMovie in jsonMovies{
                    let movie = Movie(rawData: jsonMovie)
                    self.movies.append(movie)
                }
                self.movieTableView.reloadData()
            }
        }
    }
    
    
    func resetMovies(){
        self.movies = []
    }
    
    var searchCriteria: SearchCriteriaModel!
    func setTheme(){
        // TabBarColoe
        // Sets the default color of the icon of the selected UITabBarItem and Title
        UITabBar.appearance().tintColor = UIColor.yellowColor()
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        
        // Loading Modal
        loadingModal = JGProgressHUD(style: .Dark)
        loadingModal.textLabel.text = "Loading..."
        // Error Modal
        errorModal = JGProgressHUD(style: .Dark)
        errorModal.textLabel.text = "No network connection!"
        errorModal.indicatorView = JGProgressHUDErrorIndicatorView()
        
        // Search Page
        if displayCategory == "Search" {
            // Init Criteria Model
            searchCriteria = SearchCriteriaModel()
            // Search Bar
            searchBar = UISearchBar()
            searchBar?.sizeToFit()
            searchBar?.delegate = self
            self.navigationItem.titleView = searchBar
            // Filter Button
        } else {
            // Remove Filter
            self.navigationItem.rightBarButtonItems?.removeFirst()
            
            // Now Playing & Top Rated Page
            // Segment Control
            segmentControl = UISegmentedControl()
            segmentControl.frame.size = CGSize(width: 120, height: 40)
            segmentControl.insertSegmentWithTitle("List", atIndex: 0, animated: true)
            segmentControl.insertSegmentWithTitle("Grid", atIndex: 1, animated: true)
            segmentControl.tintColor = UIColor.yellowColor()
            segmentControl.addTarget(self, action: #selector(ViewController.segmentedControlAction(_:)), forControlEvents: .ValueChanged)
            segmentControl.selectedSegmentIndex = 0
            self.navigationItem.titleView = segmentControl
        }
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchCriteria.keyWord = searchText
        searchMovies()
    }
    
    func searchMovies() {
        if self.searchCriteria.keyWord != "" {
            movieService.searchMovies(self.searchCriteria) { responseObject, error in
                self.loadingModal.dismissAfterDelay(2, animated: true)
                guard let tempData = responseObject else { print("There's nothing there"); return }
                let jsonMovies = tempData.valueForKeyPath("results") as! [NSDictionary]
                self.resetMovies()
                for jsonMovie in jsonMovies{
                    let movie = Movie(rawData: jsonMovie)
                    self.movies.append(movie)
                }
                self.movieTableView.reloadData()
            }
        }
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
        if movie.releaseDate != "" {
            cell.yearLabel.text = movie.releaseDate[movie.releaseDate.startIndex.advancedBy(0)...movie.releaseDate.startIndex.advancedBy(3)]
        }
        
        cell.rating.text = String(movie.voteAverage)
        cell.voteCount.text = String(movie.voteCount)
        
        cell.overview.text = movie.overview
        
        if let poster = movie.posterPath {
            movieService.getMoviePoster(poster, highQuality: false){ responseObject, error in
                guard let tempData = responseObject else { print("There's nothing there"); return }
                cell.poster.image = UIImage(data: tempData)
                self.movieService.getMoviePoster(poster, highQuality: true){ responseObject, error in
                    guard let tempData = responseObject else { print("There's nothing there"); return }
                    cell.poster.image = UIImage(data: tempData)
                }
            }
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
        } else if segue.identifier == "FilterSegue",
            let destination = segue.destinationViewController as? FilterViewController {
            destination.delegate = self
            if destination.criteria == nil {
                destination.criteria = self.searchCriteria
            }
            
        }
    }
}


extension ViewController : FiltersDelegate {
    func didChangedCriteria(filterController: FilterViewController, criteria: SearchCriteriaModel) {
        // update
        searchMovies()
    }
}

extension ViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

