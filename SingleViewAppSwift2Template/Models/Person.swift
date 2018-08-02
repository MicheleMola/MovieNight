//
//  Character.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct Person: Codable {
  let id: Int
  let name: String
}

extension Person: Equatable {
  static func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
  }
}

struct People: Codable {
  let total_results: Int
  let results: [Person]
}
