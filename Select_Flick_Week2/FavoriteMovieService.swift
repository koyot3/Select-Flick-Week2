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
    
    static func clickFavoriteButton(username: String, movieId: Int){
        let realm = try! Realm()
        let predicate = NSPredicate(format: "username = %@", username)
        let favoriteMovies = realm.objects(FavoriteMovieDTO.self).filter(predicate)
        if favoriteMovies.count == 0 {
            // add new
            var userFavMovies = FavoriteMovieDTO()
            userFavMovies.username = username
            
        } else {
            var favoriteMovies = favoriteMovies.first?.favouriteMovies
            // update
            if favoriteMovies!.indexForKey(movieId) != nil {
                favoriteMovies![movieId] = !(favoriteMovies![movieId]!)
            } else {

            }
            
            
        }
    }
}
