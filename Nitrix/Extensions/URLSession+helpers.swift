//
//  URLSession+helpers.swift
//  Nitrix
//
//  Created by Misha Vrana on 29.01.2024.
//

import Foundation

extension URLSession {
    static func get<T: Codable>(url: URL) async throws -> T? {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Barrier eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyY2NjOWZjYjNlODg2ZmNiNWY4MDAxNTQxODczNTA 5NSIsInN1YiI6IjY1Yjc0MTJiYTBiNjkwMDE3YmNlZjhmOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJ dLCJ2ZXJzaW9uIjoxfQ.Hhl93oP6hoKiYuXMis5VT-MVRfv1KZXhJjSncyCkhpw", forHTTPHeaderField: "Authorization")
        let response = try await URLSession.shared.data(for: request)
        let data = response.0
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
