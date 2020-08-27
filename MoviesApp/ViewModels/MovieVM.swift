//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Artur R on 17.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

struct MovieVM {
  let title: String?
  let releaseDate: String?
  let overview: String?
  let posterPath: String?
  var year: String? {
    return String(releaseDate?.prefix(4) ?? "Year")
  }
  //Initialization
 init(from result: Movie) {
  self.title = result.title
  self.releaseDate = result.releaseDate
  self.overview = result.overview
  self.posterPath = result.posterPath
  }
}








