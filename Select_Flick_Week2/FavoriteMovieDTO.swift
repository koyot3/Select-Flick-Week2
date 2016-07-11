//
//  FavoriteMovie.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/11/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteMovieDTO: Object {
    dynamic var movieId:Int = 0
    dynamic var isLike:Bool = true
    dynamic var transactionDate:NSDate!
    override static func primaryKey() -> String? {
        return "movieId"
    }
}