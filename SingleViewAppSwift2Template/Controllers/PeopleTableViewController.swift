//
//  PeopleTableViewController.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {
  
  private struct Constants {
    static let PersonCellHeight: CGFloat = 80
  }
  
  private let limit = 5
  
  lazy var dataSource: PeopleListDataSource = {
    return PeopleListDataSource(people: [], tableView: self.tableView)
  }()
  
  var people: [Person] = [] {
    didSet {
      self.dataSource.update(with: people)
      self.tableView.reloadData()
    }
  }
  
  let client = MovieDBAPIClient()
  
  var selectedPeople = [Person]()
  
  var totalPeople = Int()
  
  var watcher: Watcher?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = dataSource
    
    getPeople(fromPage: 1)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showVote" {
      if let voteTVC = segue.destination as? VoteTableViewController {
        guard var watcher = watcher else { return }
        watcher.people = selectedPeople
        voteTVC.watcher = watcher
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getPeople(fromPage page: Int) {
    client.getPeople(fromPage: page) { response in
      switch response {
      case .success(let people):
        guard let people = people else { return }
        self.people.append(contentsOf: people.results)
        self.totalPeople = people.total_results
      case .failure(let error):
        print(error)
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constants.PersonCellHeight
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedPerson = dataSource.person(at: indexPath)
    selectedPeople.append(selectedPerson)
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let deselectedPerson = dataSource.person(at: indexPath)
    if let indexOf = selectedPeople.index(of: deselectedPerson) {
      selectedPeople.remove(at: indexOf)
    }
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if selectedPeople.count == limit { return nil }
    return indexPath
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == people.count - 1 {
      if people.count < totalPeople {
        let page = ((indexPath.row + 1) / 20) + 1
        self.getPeople(fromPage: page)
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.imageView?.kf.cancelDownloadTask()
  }
  
}
