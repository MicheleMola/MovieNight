//
//  VoteTableViewController.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 02/08/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class VoteTableViewController: UITableViewController {
  @IBOutlet weak var voteLabel: UILabel!
  
  var watcher: Watcher?
  
  @IBOutlet weak var genresResume: UILabel!
  @IBOutlet weak var peopleResume: UILabel!
  
  @IBOutlet weak var saveButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
  }
  
  func configureView() {
    if let watcher = watcher {
      let genres = watcher.genres.map { $0.name }
      let people = watcher.people.map { $0.name }
    
      genresResume.text = genres.joined(separator: " - ")
      peopleResume.text = people.joined(separator: " - ")
    }
    
    saveButton.layer.borderWidth = 1
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func stepperTapped(_ sender: UIStepper) {
    voteLabel.text = "\(sender.value)"
  }
  
  @IBAction func saveTapped(_ sender: UIButton) {
    if let watcher = watcher {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(watcher) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "watcher\(watcher.identifier)")
        self.alert(withMessage: "Save Successful")
      } else {
        self.alert(withMessage: "Save Failed")
      }
    } else {
      self.alert(withMessage: "Save Failed")
    }
  }
  
  func alert(withMessage message: String) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    let closeAction = UIAlertAction(title: "Close", style: .cancel) { UIAlertAction in
      let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      let vc: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "navController") as UIViewController
      self.present(vc, animated: true, completion: nil)
    }
    alert.addAction(closeAction)
    self.present(alert, animated: true, completion: nil)
  }
}
