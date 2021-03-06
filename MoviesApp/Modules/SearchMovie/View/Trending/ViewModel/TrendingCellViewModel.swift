//
//  TrendingMovieViewModel.swift
//  MoviesApp
//
//  Created by Artur R on 18.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//



import UIKit


struct TrendingCellViewModel {
  let title: String?
  let releaseDate: String?
  let overview: String?
  let backdropPath: String?
  //Initialization
 init(from result: Movie) {
  self.title = result.title
  self.releaseDate = result.releaseDate
  self.overview = result.overview
  self.backdropPath = result.backdropPath
  }
}
