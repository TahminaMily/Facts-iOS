//
//  Fact.swift
//  Facts
//
//  Created by Tahmina Khanam on 22/2/18.
//  Copyright © 2018 Cognizant. All rights reserved.
//

import Foundation

struct Fact: Decodable {
    let title: String?
    let description: String?
    let imageHref: URL?
}
