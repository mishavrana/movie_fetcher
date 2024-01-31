//
//  FavoriteMovie+helpers.swift
//  Nitrix
//
//  Created by Misha Vrana on 30.01.2024.
//

import Foundation
import CoreData

extension FavoriteMovie {
    
    convenience init(title: String, genre: String, releaseDate: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title_ = title
        self.genre_ = genre
        self.releaseDate_ = releaseDate
    }
    
    convenience init(movie: Movie, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title_ = movie.title
        self.genre_ = "some genre"
        self.releaseDate_ = movie.releaseDate
    }
    
    static func delete(movie: FavoriteMovie) {
        guard let context = movie.managedObjectContext else { return }
        context.delete(movie)
    }
    
    var title: String {
        get { return title_ ?? "" }
    }
    
    var genre: String {
        get { return genre_ ?? "" }
    }
    
    var date: String {
        get { return releaseDate_ ?? "" }
    }
}
