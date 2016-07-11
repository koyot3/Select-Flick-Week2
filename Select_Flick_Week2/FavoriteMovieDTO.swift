//
//  FavoriteMovieDTO.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/11/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteMovieDTO : Object {
    dynamic var username:String!
    dynamic var favouriteMovies:[Int:Bool]!
}