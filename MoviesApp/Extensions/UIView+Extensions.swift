//
//  UISearchBar+Extension.swift
//  MoviesApp
//
//  Created by Artur R on 05.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

public extension UISearchBar {
  var textField : UITextField {
    let subviews = self.subviews.flatMap  { $0.subviews }
    guard let textField = (subviews.filter { $0  is UITextField }).first as? UITextField else {
      return UITextField()
    }
    return textField
  }
}

public extension UIView {
   private func setSubviewForAutoLayout(_ subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(subview)
    }
  func setSubviewsForAutoLayout(_ subviews: UIView...) {
        subviews.forEach(self.setSubviewForAutoLayout)
    }
}

