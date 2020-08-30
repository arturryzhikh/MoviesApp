//
//  SearchMovieCellViewModel.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 27.08.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

struct SearchMovieCellVM {
  let title: String?
  let releaseDate: String?
  let overview: String?
  let posterPath: String?
  let backdropPath: String? = nil
  var year: String? {
    return String(releaseDate?.prefix(4) ?? "Year")
  }
  //Initialization
 init(movie : Movie) {
  self.title = movie.title
  self.releaseDate = movie.releaseDate
  self.overview = movie.overview
  self.posterPath = movie.posterPath
  }
 
}
