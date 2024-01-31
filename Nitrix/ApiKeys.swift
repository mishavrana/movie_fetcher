//
//  ApiKeys.swift
//  Nitrix
//
//  Created by Misha Vrana on 31.01.2024.
//

import Foundation

class ApiKeys {
    static let shared = ApiKeys()
    
    private init() { }
    
    func getKey() -> String {
        if let path = Bundle.main.path(forResource: "API", ofType: "plist"),
           let keys = NSDictionary(contentsOfFile: path) {
            let apiKey = keys["api_key"] as? String
            if let apiKey { return apiKey }
        }
        return ""
    }
}
