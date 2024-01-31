//
//  URL+helpers.swift
//  Nitrix
//
//  Created by Misha Vrana on 29.01.2024.
//

import Foundation
import SwiftUI

extension URL: ExpressibleByStringLiteral {
   
    
    public init(stringLiteral value: String) {
        // Attempt to create a URL from the provided string
        if let url = URL(string: value) {
            self = url
        } else {
            fatalError("Invalid URL string: \(value)")
        }
    }
}

extension URL {
    static let apiKey = ApiKeys.shared.getKey()
    
    static func imageUrl(for path: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(path)")!
    }
    
    static func filmsList(page: String) -> URL {
        var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&sort_by=popularity.desc")!
        
        urlComponents.queryItems = []
        
        urlComponents.queryItems?.append(URLQueryItem(name: "api_key", value: URL.apiKey))
        urlComponents.queryItems?.append(URLQueryItem(name: "page", value: page))
        
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
    static func filmDetail(id: Int) -> URL {
        var urlComponents = URLComponents(string:"https://api.themoviedb.org/3/movie/\(id)?language=en-US")!
        
        urlComponents.queryItems = []
        
        urlComponents.queryItems?.append(URLQueryItem(name: "api_key", value: URL.apiKey))
        
        print(urlComponents.url!)
        return urlComponents.url!
    }

    
    
}
