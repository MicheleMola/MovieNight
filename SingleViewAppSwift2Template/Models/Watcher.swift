//
//  Watcher.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 02/08/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct Watcher: Codable {
  let identifier: Int
  var genres: [Genre] = []
  var people: [Person] = []
}
