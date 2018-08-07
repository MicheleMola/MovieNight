//
//  CharacterCell.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 28/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import Kingfisher

class PersonCell: UITableViewCell {
  
  static let reuseIdentifier = "PersonCell"
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageProfile: UIImageView!
  
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
  
  func configure(with person: Person) {
    self.nameLabel.text = person.name
  
    guard let profilePath = person.profile_path else { return }
    let url = URL(string: "https://image.tmdb.org/t/p/w200/\(profilePath)")
    self.imageProfile.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "Fill 27"))
  }
  
}
