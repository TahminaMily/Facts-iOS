//
//  Result.swift
//  Facts
//
//  Created by Tahmina Khanam on 23/2/18.
//  Copyright © 2018 Cognizant. All rights reserved.
//

import Foundation

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}
