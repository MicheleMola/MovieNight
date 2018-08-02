//
//  GenreCellViewModel.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct GenreCellViewModel {
  let name: String
}

extension GenreCellViewModel {
  init(genre: Genre) {
    self.name = genre.name
  }
}
