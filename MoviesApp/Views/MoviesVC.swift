//
//  ViewController.swift
//  MoviesApp
//
//  Created by Artur R on 24.04.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupSearchBar()
  }


}

extension MoviesVC: UISearchBarDelegate {
  
  private func setupNavigationBar() {
    //main view background
    self.view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    //color of navigation
    navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.1473975487, blue: 0.4460660192, alpha: 1)
    //color of bar button items
    navigationController?.navigationBar.tintColor = .white
    //color and font of title
    let attrs = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
    ]
    navigationController?.navigationBar.titleTextAttributes = attrs
    navigationItem.title = "Movies"
  }
  
  private func setupSearchBar() {
    //create search bar with frame right below navigaation bar
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.maxY ?? 0
      , width: view.frame.width, height: 0))
    //
    searchBar.delegate = self
    searchBar.sizeToFit()
    searchBar.barTintColor = #colorLiteral(red: 1, green: 0.1473975487, blue: 0.4460660192, alpha: 1)
    searchBar.tintColor = .white
    for view in searchBar.subviews {    //change text field background color, text color
        for subview in view.subviews {
            if subview is UITextField {
              guard let textField = subview as? UITextField else { return }
              textField.backgroundColor = #colorLiteral(red: 0.5496635658, green: 0.08103376437, blue: 0.2457754123, alpha: 1)
              textField.textColor = .white
            }
        }
    }
    searchBar.backgroundColor = .black  //outline color
    searchBar.showsCancelButton = true
    searchBar.searchBarStyle = .default
    searchBar.placeholder = "Type To Search Movies"
    searchBar.enablesReturnKeyAutomatically = true
    view.addSubview(searchBar)
  }
}
