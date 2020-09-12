//
//  HTTPResponse.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 12.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//
import Foundation
extension HTTPURLResponse {
  var statusOK: Bool {
    return  (200...299).contains(statusCode)
  }
}

