//
//  GenresListDataSource.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class GenresListDataSource: NSObject, UITableViewDataSource {
  
  private var genres: [Genre]
  
  init(genres: [Genre]) {
    self.genres = genres
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return genres.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let genreCell = tableView.dequeueReusableCell(withIdentifier: GenreCell.reuseIdentifier, for: indexPath) as! GenreCell
    
    let genre = genres[indexPath.row]
    
    genreCell.configure(with: genre)
    
    return genreCell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Choose Max 5 items"
  }
  
  func update(with genres: [Genre]) {
    self.genres = genres
  }
  
  func genre(at indexPath: IndexPath) -> Genre {
    return genres[indexPath.row]
  }
  

}
