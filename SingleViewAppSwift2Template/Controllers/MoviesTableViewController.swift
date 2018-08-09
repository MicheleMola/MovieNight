//
//  MoviesTableViewController.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 04/08/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
  
  private struct Constants {
    static let MovieCellHeight: CGFloat = 80
  }
  
  private let limit = 5
  
  lazy var dataSource: MoviesListDataSource = {
    return MoviesListDataSource(movies: [])
  }()
  
  var movies: [Movie] = [] {
    didSet {
      self.dataSource.update(with: movies)
      self.tableView.reloadData()
    }
  }
  var totalPeople = Int()
  
  let client = MovieDBAPIClient()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = dataSource
    
    setupView(withPage: 1)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showMovieDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let movieDetailTVC = segue.destination as! MovieDetailTableViewController
        movieDetailTVC.movie = movies[indexPath.row]
      }
    }
  }
  
  func setupView(withPage page: Int) {
    if let watcherOne = getWatcher(withKey: "watcher0"), let watcherTwo = getWatcher(withKey: "watcher1") {
      let genresIdsWatcherOne = watcherOne.genres.map { "\($0.id)" }
      let genresIdsWatcherTwo = watcherTwo.genres.map { "\($0.id)" }
      let genresIds = Array(Set(genresIdsWatcherOne + genresIdsWatcherTwo)).joined(separator: " | ")
      
      let peopleIdsWatcherOne = watcherOne.people.map { "\($0.id)" }
      let peopleIdsWatcherTwo = watcherTwo.people.map { "\($0.id)" }
      let peopleIds = Array(Set(peopleIdsWatcherOne + peopleIdsWatcherTwo)).joined(separator: " | ")
      
      let avgVoteWatcherOne = watcherOne.avgVoteGTE
      let avgVoteWatcherTwo = watcherTwo.avgVoteGTE
      let avgTotale = (avgVoteWatcherOne + avgVoteWatcherTwo) / 2
      
      getMovies(fromPage: page, peopleIds: peopleIds, genresIds: genresIds, avgVote: "\(avgTotale)")
    }
  }
  
  func getMovies(fromPage page: Int, peopleIds: String, genresIds: String, avgVote: String) {
    client.getMovies(fromPage: page, peopleIds: peopleIds, genresIds: genresIds, avgVote: avgVote) { [unowned self] response in
      switch response {
      case .success(let movies):
        guard let movies = movies else { return }
        self.movies.append(contentsOf: movies.results)
        self.totalPeople = movies.total_results
      case .failure(let error):
        self.alertController(message: error.rawValue)
      }
    }
  }
  
  func getWatcher(withKey key: String) -> Watcher? {
    if let savedWatcher = UserDefaults.standard.object(forKey: key) as? Data {
      let decoder = JSONDecoder()
      if let loadedWatcher = try? decoder.decode(Watcher.self, from: savedWatcher) {
        return loadedWatcher
      }
    }
    return nil
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constants.MovieCellHeight
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == movies.count - 1 {
      if movies.count < totalPeople {
        let page = ((indexPath.row + 1) / 20) + 1
        self.setupView(withPage: page)
      }
    }
  }
  
}
