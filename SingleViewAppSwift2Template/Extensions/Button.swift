//
//  Button.swift
//  SingleViewAppSwift2Template
//
//  Created by Michele Mola on 27/07/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

// Inspectable image content mode
extension UIButton {
  /// 0 => .ScaleToFill
  /// 1 => .ScaleAspectFit
  /// 2 => .ScaleAspectFill
  @IBInspectable
  var imageContentMode: Int {
    get {
      return self.imageView?.contentMode.rawValue ?? 0
    }
    set {
      if let mode = UIViewContentMode(rawValue: newValue),
        self.imageView != nil {
        self.imageView?.contentMode = mode
      }
    }
  }
}
