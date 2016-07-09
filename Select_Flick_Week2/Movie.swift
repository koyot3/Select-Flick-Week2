//
//  Movie.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/2/16.
//  Copyright © 2016 koyot3. All rights reserved.
//
import Foundation

struct Movie {
    var id:Int
    var originalTitle:String
    var posterPath:String?
    var overview:String
    var backDropPath:String?
    var voteAverage: Float
    var releaseDate: String
    var voteCount: Float
    
    init(rawData: AnyObject) {
        id = rawData.valueForKeyPath("id") as! Int
        originalTitle = rawData.valueForKeyPath("original_title") as! String
        posterPath = rawData.valueForKeyPath("poster_path") as? String
        overview = rawData.valueForKeyPath("overview") as! String
        backDropPath = rawData.valueForKeyPath("backdrop_path") as? String
        voteAverage = rawData.valueForKeyPath("vote_average") as! Float
        releaseDate = rawData.valueForKeyPath("release_date") as! String
        voteCount = rawData.valueForKeyPath("vote_count") as! Float
    }
    // using getter to retrieve many poster resolution 
}
