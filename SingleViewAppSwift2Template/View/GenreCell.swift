//
//  GenreCell.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class GenreCell: UITableViewCell {
  
  static let reuseIdentifier = "GenreCell"
  
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    self.accessoryType = selected ? .checkmark : .none
  }
  
  func configure(with genre: Genre) {
    titleLabel.text = genre.name
  }

  
}
