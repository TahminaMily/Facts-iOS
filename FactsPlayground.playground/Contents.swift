//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

let url = URL(string: urlString)!


struct Fact: Decodable {
    let title: String?
    let description: String?
    let imaheHref: String?
}

struct Factum: Decodable {
    let title: String
    let facts: [Fact]
    
    enum CodingKeys: String, CodingKey {
        case title
        case facts = "rows"
    }
}


URLSession.shared.dataTask(with: url) { (data, response, error) in
    //guard let data: Data = data else { return }
    guard let data: Data = String(data: data!, encoding: .isoLatin1)?.data(using: .utf8) else { return }
    
    let factum = try? JSONDecoder().decode(Factum.self, from: data)
    print(factum as Any)
    }
    .resume()































PlaygroundPage.current.needsIndefiniteExecution = true

