//
//  MovieDetailViewModel.swift
//  Nitrix
//
//  Created by Misha Vrana on 30.01.2024.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    
    func getMoviDetail(id: Int) {
        let url = URL.filmDetail(id: id)
        Task {
            let movieDetail: MovieDetail? = try! await URLSession.get(url: url)
            await MainActor.run { [weak self] in
                self?.movieDetail = movieDetail
            }
        }
    }
}
