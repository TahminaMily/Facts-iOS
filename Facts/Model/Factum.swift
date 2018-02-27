//
//  Factum.swift
//  Facts
//
//  Created by Tahmina Khanam on 22/2/18.
//  Copyright © 2018 Cognizant. All rights reserved.
//

import Foundation

struct Factum: Decodable {
    let title: String
    var facts: [Fact]
    
    enum CodingKeys: String, CodingKey {
        case title
        case facts = "rows"
    }
}
