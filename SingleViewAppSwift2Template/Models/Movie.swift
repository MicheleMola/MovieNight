//
//  Movie.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 04/08/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct Movie: Codable {
  let title: String
  let release_date: String
  let overview: String
  let poster_path: String?
  let backdrop_path: String?
  let vote_average: Double
  let adult: Bool
}

struct Movies: Codable {
  let total_results: Int
  let results: [Movie]
}
