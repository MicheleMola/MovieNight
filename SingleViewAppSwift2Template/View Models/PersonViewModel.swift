//
//  PersonViewModel.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 04/08/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

enum ProfileImageState {
  case placeholder
  case downloaded
  case failed
}

struct PersonViewModel {
  let name: String
  let profilePath: String
  var imageProfileState = ProfileImageState.placeholder
  var imageProfile = #imageLiteral(resourceName: "deselectedUser")
}

extension PersonViewModel {
  init(person: Person) {
    self.name = person.name
    self.profilePath = "https://image.tmdb.org/t/p/w200/\(person.profile_path)"
  }
}
