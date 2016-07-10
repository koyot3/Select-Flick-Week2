//
//  MovieDbService.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/2/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import Foundation
import Alamofire

struct MovieDbService {
    let apiKey = "fbbacaf37d0caa882210c20b93b900bf"
    let movieDbUrl = "https://api.themoviedb.org/3"
    let imageDbUrl = "http://image.tmdb.org/t/p/w500"
    let lowImgDbUrl = "https://image.tmdb.org/t/p/w45"
   
    func getLatestMovies(completionHandler: (NSDictionary?, NSError?) -> ()) {
        let params = ["api_key":apiKey , "sort_by": "popularity.desc"]
        makeCallJson(params, section: "/discover/movie", method: Alamofire.Method.GET, completionHandler: completionHandler)
    }
    
    func getNowPlayingMovies(completionHandler: (NSDictionary?, NSError?) -> ()) {
        let params = ["api_key":apiKey]
        makeCallJson(params, section: "/movie/now_playing", method: Alamofire.Method.GET, completionHandler: completionHandler)
    }
    
    func getTopRatedMovies(completionHandler: (NSDictionary?, NSError?) -> ()) {
        let params = ["api_key":apiKey]
        makeCallJson(params, section: "/movie/top_rated", method: Alamofire.Method.GET, completionHandler: completionHandler)
    }
    
    func getMoviePoster(posterUrl: String, highQuality:Bool, completionHandler: (NSData?, NSError?) -> ()) {
        let params = ["api_key":apiKey]
        var url = lowImgDbUrl
        if highQuality {
            url = imageDbUrl
        }
        makeCallData(params, section: url + posterUrl, method: Alamofire.Method.GET, completionHandler: completionHandler)
    }
    
    func makeCallJson(params: AnyObject , section: String, method: Alamofire.Method, completionHandler: (NSDictionary?, NSError?) -> ()) {
        Alamofire.request(.GET, movieDbUrl + section, parameters: params as! [String : AnyObject])
            .responseJSON { response in
                switch response.result {
                case .Success(let value):
                    completionHandler(value as? NSDictionary, nil)
                case .Failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
    func makeCallData(params: AnyObject , section: String, method: Alamofire.Method, completionHandler: (NSData?, NSError?) -> ()) {
        Alamofire.request(.GET, section, parameters: params as! [String : AnyObject])
            .responseData { response in
                switch response.result {
                case .Success(let value):
                    completionHandler(value as NSData, nil)
                case .Failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
}