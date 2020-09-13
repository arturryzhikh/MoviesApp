//
//  Request.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation

protocol APIRequest: Encodable {
  associatedtype Response: Decodable
  var endPoint: String { get }
  func url() -> URL
}
