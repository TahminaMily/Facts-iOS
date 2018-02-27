//
//  FactsDataSource.swift
//  Facts
//
//  Created by Tahmina Khanam on 22/2/18.
//  Copyright © 2018 Cognizant. All rights reserved.
//

import Foundation

enum APIError: Swift.Error {
    case networkError
    case jsonDecodingError
}

struct FactsDataSource {
    private let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    public func fetch(completionHandler: ( @escaping (Result<Factum, APIError>) -> Void)) {
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return completionHandler(.failure(.networkError))
            }
            guard
                let data: Data = String(data: data!, encoding: .isoLatin1)?.data(using: .utf8),
                let factum = try? JSONDecoder().decode(Factum.self, from: data)
                else {
                    return completionHandler(.failure(.jsonDecodingError))
            }
            
            return completionHandler(.success(factum))
            }.resume()
    }
}


