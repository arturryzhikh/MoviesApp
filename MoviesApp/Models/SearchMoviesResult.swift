//
//  SearchMoviesResult.swift
//  MoviesApp
//
//  Created by Artur R on 16.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//


struct SearchMoviesResult: Decodable {
  
  let page, totalResults, totalPages : Int?
  let results: [MovieListResult]?
}
struct MovieListResult: Decodable {
  let popularity, voteAvarage: Double?
  let voteCount, id: Int?
  let video,adult: Bool?
  let originalLanguage,
  originalTitle,
  backdropPath,
  posterPath,
  overview,
  releaseDate,title : String?
  let genreIDS: [Int]?
}
