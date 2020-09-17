//
//  Movie.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 17.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//



struct Movie: Decodable {
  let title : String?
  let releaseDate: String?
  let overview: String?
  let backdropPath: String?
  let posterPath: String?
  let popularity: Double?
  let voteAvarage: Double?
  let id: Int?
  let video: Bool?
  let adult: Bool?
  let originalLanguage: String?
  let originalTitle: String?
  let genreIDS: [Int]?
}
