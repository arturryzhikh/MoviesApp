//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Artur R on 17.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

struct MovieViewModel {
  let title: String?
  let releaseDate: String?
  let overview: String?
  let poster: UIImage? = nil
  let posterPath: String?
  //Initialization
 init(from result: MovieListResult) {
  self.title = result.title
  self.releaseDate = result.releaseDate
  self.overview = result.overview
  self.posterPath = result.posterPath
  }
}





