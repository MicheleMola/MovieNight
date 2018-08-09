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
    return PeopleListDataSource(people: [])
  }()
  
  var people: [Person] = []
  
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
        self.updateDataSource(withPeople: people.results)
        self.totalPeople = people.total_results
      case .failure(let error):
        self.alertController(message: error.rawValue)
      }
    }
  }
  
  func updateDataSource(withPeople people: [Person]) {
    self.dataSource.update(with: people)
    self.tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constants.PersonCellHeight
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
      if cell.accessoryType == .checkmark {
        cell.accessoryType = .none
        
        let deselectedPerson = dataSource.person(at: indexPath)
        if let indexOf = selectedPeople.index(of: deselectedPerson) {
          selectedPeople.remove(at: indexOf)
        }
        
        dataSource.deselectPerson(at: indexPath)
        
      } else {
        cell.accessoryType = .checkmark
        
        let selectedPerson = dataSource.person(at: indexPath)
        selectedPeople.append(selectedPerson)
        
        dataSource.selectPerson(at: indexPath)
      }
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
  
}
