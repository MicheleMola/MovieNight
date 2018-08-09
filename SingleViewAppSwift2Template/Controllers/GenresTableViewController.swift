//
//  GenresTableViewController.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class GenresTableViewController: UITableViewController {
  
  private struct Constants {
    static let GenreCellHeight: CGFloat = 60
  }
  
  private let limit = 5
  
  lazy var dataSource: GenresListDataSource = {
    return GenresListDataSource(genres: [])
  }()
  
  var genres: [Genre] = [] {
    didSet {
      self.dataSource.update(with: genres)
      self.tableView.reloadData()
    }
  }
  
  let client = MovieDBAPIClient()

  var selectedGenres = [Genre]()
  
  var watcher: Watcher?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = dataSource
        
    getGenres()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showPeople" {
      if let peopleTVC = segue.destination as? PeopleTableViewController {
        guard var watcher = watcher else { return }
        watcher.genres = selectedGenres
        peopleTVC.watcher = watcher
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getGenres() {
    client.getGenres { response in
      switch response {
      case .success(let genres):
        guard let genres = genres?.genres else { return }
        self.genres = genres
      case .failure(let error):
        self.alertController(message: error.rawValue)
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constants.GenreCellHeight
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedGenre = dataSource.genre(at: indexPath)
    selectedGenres.append(selectedGenre)
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let deselectedGenre = dataSource.genre(at: indexPath)
    if let indexOf = selectedGenres.index(of: deselectedGenre) {
      selectedGenres.remove(at: indexOf)
    }
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if selectedGenres.count == limit { return nil }
    return indexPath
  }
  
  
}
