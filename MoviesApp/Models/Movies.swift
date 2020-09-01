//
//  SearchMoviesResult.swift
//  MoviesApp
//
//  Created by Artur R on 16.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//


struct Movies: Decodable {
  
  let results: [Movie]?
  ///uncomment lines to retrieve other properties
//  let page: Int?
//  let totalResults: Int?
//  let totalPages: Int?
}

struct Movie: Decodable {
  let title : String?
  let releaseDate: String?
  let overview: String?
  let backdropPath: String?
  let posterPath: String?
  let popularity: Double?
///uncomment lines to retrieve other properties
//  let voteAvarage: Double?

//  let id: Int?
//  let video: Bool?
//  let adult: Bool?
//  let originalLanguage: String?
//  let originalTitle: String?
//  let genreIDS: [Int]?
}
