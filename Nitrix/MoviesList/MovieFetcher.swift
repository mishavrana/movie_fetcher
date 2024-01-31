//
//  MovieFetcher.swift
//  Nitrix
//
//  Created by Misha Vrana on 31.01.2024.
//

import Foundation

protocol PageFetcher {
    func fetch<T: Decodable>(page: Int) async throws -> [T]?
}

class MovieFetcher: PageFetcher {
    func fetch<T>(page: Int) async throws -> [T]? where T : Decodable {
        let url = URL.filmsList(page: "\(page)")
        let result: MovieResponse? = try await URLSession.get(url: url)
        return result?.results as? [T]
    }
}
