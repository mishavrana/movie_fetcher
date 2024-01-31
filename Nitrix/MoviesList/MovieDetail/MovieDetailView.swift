//
//  MovieDetailView.swift
//  Nitrix
//
//  Created by Misha Vrana on 30.01.2024.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject private var viewModel = MovieDetailViewModel()
    
    var imageUrl: URL? {
        guard let path = viewModel.movieDetail?.backdropPath else { return nil }
        return URL.imageUrl(for: path)
    }
    
    var title: String {
        viewModel.movieDetail?.title ?? ""
    }
    
    var desctiption: String {
        viewModel.movieDetail?.overview ?? ""
    }
    
    var releaseDate: String {
        viewModel.movieDetail?.releaseDate ?? ""
    }
    
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack {
                
                if let imageUrl {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                }

                Text(title)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                
                Text(desctiption)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 40)
                
                Text(releaseDate)
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .trailingFirstTextBaseline)
                
            }
            .padding()
        }
        .onAppear {
            viewModel.getMoviDetail(id: movie.id)
        }
    }
}

#Preview {
    MovieDetailView(
        movie: Movie(
            id: 1234,
            adult: true,
            backdropPath: nil,
            genreIds: nil,
            originalLanguage: "en",
            originalTitle: "Some Title",
            overview: "",
            popularity: nil,
            posterPath: "",
            releaseDate: "",
            title: "",
            video: nil,
            voteAverage: nil,
            voteCount: nil
        )
    )
}
