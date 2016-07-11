//
//  FavoriteMovieService.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/11/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteMovieService {

    static func getFavoriteMovies(username: String) -> UserFavoriteMoviesDTO {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "username = %@", username)
        let favoriteMovies = realm.objects(UserFavoriteMoviesDTO.self).filter(predicate)
        if favoriteMovies.count == 0 {
            return UserFavoriteMoviesDTO()
        } else {
            return (favoriteMovies.first)!
        }
    }
    
    static func clickFavoriteButton(username: String, movieId: Int){
        let realm = try! Realm()
        let predicate = NSPredicate(format: "username = %@", username)
        let favoriteMovies = realm.objects(UserFavoriteMoviesDTO.self).filter(predicate)
        realm.beginWrite()
        if favoriteMovies.count == 0 {
            // add new
            var userFavMovies = UserFavoriteMoviesDTO()
            userFavMovies.username = username
            var movie = FavoriteMovieDTO()
            movie.movieId = movieId
            movie.isLike = true
            movie.transactionDate = NSDate()
            userFavMovies.favouriteMovies.append(movie)
            try! realm.write() {
                realm.create(UserFavoriteMoviesDTO.self, value: userFavMovies)
            }
            
        } else {
            var isFound:Bool = false
            for movie in (favoriteMovies.first?.favouriteMovies)! {
                let m = movie as! FavoriteMovieDTO
                if m.movieId == movieId {
                    m.isLike = !movie.isLike
                    m.transactionDate = NSDate()
                    isFound = true
                }
            }
            if isFound == false {
                let movie = FavoriteMovieDTO()
                movie.movieId = movieId
                movie.isLike = true
                movie.transactionDate = NSDate()
                favoriteMovies.first?.favouriteMovies.append(movie)
            }
            try! realm.write() {
                realm.create(UserFavoriteMoviesDTO.self, value: (favoriteMovies.first?.favouriteMovies)!, update: true)
            }
        }
    }
}
