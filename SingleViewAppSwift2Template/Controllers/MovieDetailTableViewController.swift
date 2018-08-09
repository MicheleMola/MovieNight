//
//  MovieDetailTableViewController.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 09/08/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailTableViewController: UITableViewController {
  
  var movie: Movie?
  
  @IBOutlet weak var backdropImage: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var voteAVGLabel: UILabel!
  @IBOutlet weak var adultImageView: UIImageView!
  @IBOutlet weak var overviewTextView: UITextView!
  @IBOutlet weak var releaseDateLabel: UILabel!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  func setupView() {
    if let movie = movie {
      if let backdropPath = movie.backdrop_path, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(backdropPath)") {
        backdropImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"))
      }
      
      movieTitle.text = movie.title
      
      voteAVGLabel.text = "AVG Rating: \(movie.vote_average)"
      
      overviewTextView.text = movie.overview
      
      releaseDateLabel.text = movie.release_date
      
      adultImageView.image = movie.adult ? #imageLiteral(resourceName: "adult") : #imageLiteral(resourceName: "notAdult")
    }
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
