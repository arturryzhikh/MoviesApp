//
//  UIView+setSubviewsForAutoLayout.swift
//  MoviesApp
//
//  Created by Artur R on 24.04.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit
extension UIView {
   
    private func setSubviewForAutoLayout(_ subview: UIView) {
            subview.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subview)
        }
    func setSubviewsForAutoLayout(_ subviews: [UIView]) {
        subviews.forEach(self.setSubviewForAutoLayout)
        }
    
}
