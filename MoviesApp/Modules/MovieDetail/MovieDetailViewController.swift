//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Artur R on 08.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit



final class MovieDetailViewController: UIViewController {
  //MARK: instance properties
  
  private var activityIndicator: UIActivityIndicatorView!
  
  var movieViewModel: MovieViewModel! {
    didSet {
      titleLabel.text = movieViewModel.title
      yearLabel.text = movieViewModel.year
      overviewTextView.text = movieViewModel.overview
      if let urlString = movieViewModel.backdropURLString {
        backdropImageView.loadImage(urlString: urlString)
      }
      
    }
    
  }
    
  //MARK: life cycle
    override func viewDidLoad() {
      super.viewDidLoad()
      
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      setupNavigationBar()
      setupView()
     
    }
    
  //MARK:Subviews
 private let backdropImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFill
    iv.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    iv.clipsToBounds = true
    return iv
  }()

  private let titleLabel: UILabel = {
     let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.backgroundColor = UIColor.black.withAlphaComponent(0)
    lbl.numberOfLines = 0
    lbl.textAlignment = .natural
    lbl.lineBreakMode = .byWordWrapping
    lbl.font = UIFont.boldSystemFont(ofSize: 24)
    lbl.textColor = .white
    return lbl
   }()
  private let yearLabel: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    lbl.numberOfLines = 0
    lbl.textAlignment = .left
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textColor = .white
     return lbl
  }()
  private let overviewTextView: UITextView = {
    let lbl = UITextView()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textColor = .white
    lbl.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    return lbl
  }()
  private func setupView() {
    self.view.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    //add subviews
    view.addSubview(backdropImageView)
    view.addSubview(titleLabel)
    view.addSubview(yearLabel)
    view.addSubview(overviewTextView)
    activityIndicator = UIActivityIndicatorView(style: .white)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()
    view.addSubview(activityIndicator)
    NSLayoutConstraint.activate([

    backdropImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
    backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    backdropImageView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.3),
    
    activityIndicator.centerXAnchor.constraint(equalTo: backdropImageView.centerXAnchor),
    activityIndicator.centerYAnchor.constraint(equalTo: backdropImageView.centerYAnchor),
 
    titleLabel.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor, constant: 6),
    titleLabel.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor, constant: -6),
    titleLabel.heightAnchor.constraint(equalTo: backdropImageView.heightAnchor, multiplier: 0.2),
    titleLabel.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -30),
    
    
    yearLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 6),
    yearLabel.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor, constant: 6),
    yearLabel.heightAnchor.constraint(equalTo: backdropImageView.heightAnchor,multiplier: 0.2),
    yearLabel.widthAnchor.constraint(equalTo: backdropImageView.widthAnchor,multiplier: 0.15),

    overviewTextView.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 6),
    overviewTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -6),
    overviewTextView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor),
    overviewTextView.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor)
    ])
  }

  
  //MARK: Subview
  private func setupNavigationBar() {
    navigationController?.navigationBar.isTranslucent = true
    //make bar transparent
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    //make bar separator transparent
    navigationController?.navigationBar.shadowImage = UIImage()
    //color of bar button items
    navigationController?.navigationBar.tintColor = .white
 
    
  }
}


