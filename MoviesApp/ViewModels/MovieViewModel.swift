//
//  SearchMovieCellViewModel.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 27.08.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

struct MovieViewModel {
  let title: String?
  let releaseDate: String?
  let overview: String?
  private let posterPath: String?
  private let backdropPath: String?
  lazy var backdropURLString: String?  = {
    if let backdropPath = backdropPath {
      return API.imageEndpoint + backdropPath
    } else {
      return nil
    }
  }()
  
  lazy var posterURLString: String? =  {
    if let posterPath = posterPath {
      return API.imageEndpoint + posterPath
    } else {
      return nil
    }
  }()
  
  
  lazy var year: String = {
    return String(releaseDate?.prefix(4) ?? "Year")
  }()
  init(movie : Movie) {
    self.title = movie.title
    self.releaseDate = movie.releaseDate
    self.overview = movie.overview
    self.posterPath = movie.posterPath
    self.backdropPath = movie.backdropPath
  }
 
}
