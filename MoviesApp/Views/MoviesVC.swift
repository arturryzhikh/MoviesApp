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
      self.view.setSubviewsForAutoLayout([searchBar])
      layoutSearchBar()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

  }
    
  
  //MARK: Subviews
  //SearchBar
  let searchBar: UISearchBar = {
     let sb = UISearchBar(frame: .zero)
      sb.sizeToFit()
      sb.barTintColor = #colorLiteral(red: 1, green: 0.1473975487, blue: 0.4460660192, alpha: 1)
      sb.tintColor = .white
      sb.backgroundColor = .black  //outline color
      sb.showsCancelButton = true
      sb.searchBarStyle = .default
      sb.enablesReturnKeyAutomatically = true
      return sb
   }()
   
}

extension MoviesVC: UISearchBarDelegate {
  
 
}
private extension MoviesVC {

  func layoutSearchBar() {
    if #available(iOS 11.0, *) {
      NSLayoutConstraint.activate([searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)])
      
    } else {
      NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ])
    }
  }
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
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)
    ]
    navigationController?.navigationBar.titleTextAttributes = attrs
    navigationItem.title = "Movies"
  }
  
}
