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
  var poster: UIImage?
  let posterPath: String?
  //Initialization
 init(from result: Result) {
  self.title = result.title
  self.releaseDate = result.releaseDate
  self.overview = result.overview
  self.posterPath = result.posterPath
  }
}





