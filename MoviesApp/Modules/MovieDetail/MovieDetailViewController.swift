//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Artur R on 08.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit



class MovieDetailViewController: UIViewController {
//MARK: instance properties
  var movieViewModel: MovieViewModel?
//MARK: life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationBar()
  }
  
  
  //MARK: Subview
  private func setupNavigationBar() {
    navigationController?.navigationBar.isTranslucent = true
    //make bar transparent
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    //make bar separator transparent
    navigationController?.navigationBar.shadowImage = UIImage()
    //color of bar button items
    navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    
  }
}
  
    

