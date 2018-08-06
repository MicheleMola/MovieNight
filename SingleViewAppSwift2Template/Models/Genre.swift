//
//  Genre.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct Genre: Codable {
  let id: Int
  let name: String
}

extension Genre: Equatable {
  static func ==(lhs: Genre, rhs: Genre) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
  }
}

struct Genres: Codable {
  let genres: [Genre]
}
