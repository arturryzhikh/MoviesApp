//
//  ImageRequest.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation

struct ImageRequest {
  var path: String
  var stringURL: String {
    return Api.imageBaseURL + path
  }
  init?(path: String?) {
    if let path = path {
      self.path = path
    }
    else {
      return nil
    }
  }
  
}


