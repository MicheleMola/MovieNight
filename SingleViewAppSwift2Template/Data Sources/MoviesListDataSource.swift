//
//  MoviesListDataSource.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 04/08/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class MoviesListDataSource: NSObject, UITableViewDataSource {

  private var movies: [Movie]
  
  init(movies: [Movie]) {
    self.movies = movies
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell

    let movie = movies[indexPath.row]
    
    movieCell.configure(movie: movie)
    
    return movieCell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Chosen for you"
  }
  
  func update(with movies: [Movie]) {
    self.movies = movies
  }
  
  func movie(at indexPath: IndexPath) -> Movie {
    return movies[indexPath.row]
  }
  
}
