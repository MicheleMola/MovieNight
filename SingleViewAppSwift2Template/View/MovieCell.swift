//
//  MovieCell.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 04/08/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
  
  static let reuseIdentifier = "MovieCell"
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configure(movie: Movie) {
    
    self.titleLabel.text = movie.title
    
    guard let posterPath = movie.poster_path else { return }
    let url = URL(string: "https://image.tmdb.org/t/p/w200/\(posterPath)")
    self.posterImageView?.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"))
  }
  
}
