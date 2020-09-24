//
//  ApiClient.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

//Protocols
typealias ResultClosure<Value> = (Result<Value, ResponseError>) -> Void

protocol APIClient {
  
  var session: URLSession { get }
  
  func request<T:APIRequest>(_ request: T,
                          completion: @escaping ResultClosure<T.Response>)
  
  func decode<T:Decodable>(data : Data,
                           into model: T.Type) -> T?
  
  func makeURL(endPoint: String,
               parameters: [String: String]) -> URL
}

