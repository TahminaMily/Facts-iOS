//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

struct Fact: Decodable {
    let title: String?
    let description: String?
    let imageHref: URL?
}

struct Factum: Decodable {
    let title: String
    let facts: [Fact]
    
    enum CodingKeys: String, CodingKey {
        case title
        case facts = "rows"
    }
}

enum Result<V, E: Swift.Error> {
    case success(V)
    case failure(E)
}

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

let datasource = FactsDataSource()

datasource.fetch { result in
    print(result)
}
