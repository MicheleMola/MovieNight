//
//  PeopleListDataSource.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class PeopleListDataSource: NSObject, UITableViewDataSource {
  
  private var people: [Person]
    
  init(people: [Person]) {
    self.people = people
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let personCell = tableView.dequeueReusableCell(withIdentifier: PersonCell.reuseIdentifier, for: indexPath) as! PersonCell
    
    let person = people[indexPath.row]
   
    personCell.configure(with: person)
    
    return personCell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Choose Max 5 People"
  }
  
  func update(with people: [Person]) {
    self.people.append(contentsOf: people)
  }
  
  func person(at indexPath: IndexPath) -> Person {
    return people[indexPath.row]
  }

  func selectPerson(at indexPath: IndexPath) {
    people[indexPath.row].isSelected = true
  }
  
  func deselectPerson(at indexPath: IndexPath) {
    people[indexPath.row].isSelected = false
  }
  
}
