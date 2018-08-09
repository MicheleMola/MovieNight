//
//  ViewController.swift
//  SingleViewAppSwift2Template
//
//  Created by Treehouse on 9/19/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var watcherOneButton: UIButton!
  @IBOutlet weak var watcherTwoButton: UIButton!
  
  @IBOutlet weak var labelStatusOne: UILabel!
  @IBOutlet weak var labelStatusTwo: UILabel!
  
  @IBOutlet weak var resultsButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showPreferences" {
      if let genresTVC = segue.destination as? GenresTableViewController {
        guard let tag = sender as? Int else { return }
        
        let watcher = Watcher(identifier: tag, genres: [], people: [], avgVoteGTE: 1.0)
        genresTVC.watcher = watcher
      }
    }
  }
  
  func setupView() {
    
    let isKeyOnePresentInUserDefaults = isKeyPresentInUserDefaults(key: "watcher0")
    let isKeyTwoPresentInUserDefaults = isKeyPresentInUserDefaults(key: "watcher1")
    
    if isKeyOnePresentInUserDefaults {
      watcherOneButton.setImage(#imageLiteral(resourceName: "selectedUser"), for: .normal)
      labelStatusOne.text = "Ready!"
    }
    
    if isKeyTwoPresentInUserDefaults {
      watcherTwoButton.setImage(#imageLiteral(resourceName: "selectedUser"), for: .normal)
      labelStatusTwo.text = "Ready!"
    }
    
    resultsButton.isEnabled = isKeyOnePresentInUserDefaults && isKeyTwoPresentInUserDefaults
    resultsButton.alpha = isKeyOnePresentInUserDefaults && isKeyTwoPresentInUserDefaults ? 1.0 : 0.6
  }
  
  func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func WatcherTapped(_ sender: UIButton) {
    performSegue(withIdentifier: "showPreferences", sender: sender.tag)
  }
  
  @IBAction func clearTapped(_ sender: UIBarButtonItem) {
    UserDefaults.standard.removeObject(forKey: "watcher0")
    UserDefaults.standard.removeObject(forKey: "watcher1")
    
    watcherOneButton.setImage(#imageLiteral(resourceName: "deselectedUser"), for: .normal)
    watcherTwoButton.setImage(#imageLiteral(resourceName: "deselectedUser"), for: .normal)
    
    labelStatusOne.text = "Tap to enter preferences"
    labelStatusTwo.text = "Tap to enter preferences"
    
    resultsButton.isEnabled = false
    resultsButton.alpha = 0.6
  }
  
}

