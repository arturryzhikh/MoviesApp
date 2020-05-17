//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Artur R on 17.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

struct ResultViewModel {
  var title: String? = "Title"
  var releaseDate: String? = "Year"
  var overview: String? = "Overview"
  var backdropImage: UIImage = #imageLiteral(resourceName: "TMBdLogo")
  var backdropPath: String?
  //Initialization
 init(from result: Result) {
  self.title = result.title
  self.releaseDate = result.releaseDate
  self.overview = result.overview
//  if let backdropPath = result.backdropPath {
//    self.backdropImage = self.loadBackdropImage(backdropPath: backdropPath)
//  }
  
  }
  
}


private extension ResultViewModel {
  mutating func loadBackdropImage(backdropPath: String) -> UIImage? {
    
    let url = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
      if let data = try? Data(contentsOf: url!) {
        if let image = UIImage(data: data) {
            return image
        }
      }
    return nil
  }
  
}

