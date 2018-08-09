//
//  UIViewController+Alert.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 09/08/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

extension UIViewController {
  func alertController(withTitle title: String = "Alert", message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
