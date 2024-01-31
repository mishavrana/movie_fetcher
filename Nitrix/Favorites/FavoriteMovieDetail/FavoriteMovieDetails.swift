//
//  FavoriteMovieDetail.swift
//  Nitrix
//
//  Created by Misha Vrana on 31.01.2024.
//

import SwiftUI

struct FavoriteMovieDetail: View {
    let favoriteMovie: FavoriteMovie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(favoriteMovie.title )
                    .font(.title)
                    .padding(.vertical)
                
                Text("Genres: \(favoriteMovie.genre)")
                    .font(.subheadline)
                    .padding(.vertical)
                
                Text("Release date: \(favoriteMovie.date)")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}
