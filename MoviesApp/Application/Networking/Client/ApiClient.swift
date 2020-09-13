//
//  ApiClient.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation
//Protocols
typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

protocol APIClient {
  var session: URLSession { get }
  
  func send<T:APIRequest>(_ request: T,
                          completion: @escaping ResultCallback<T.Response>)
  
  func decode<T:Decodable>(data : Data,
                           into model: T.Type) -> T?
  
  func getImage<T:APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>)
}

//API Client Class
final class Client: APIClient {
  //Download Image
  func getImage<T>(_ request: T,
                   completion: @escaping ResultCallback<T.Response>) where T : APIRequest {
    
  }
  //Shared Session
  let session: URLSession
  //Initialization
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  //Decoding JSON
  func decode<T>(data: Data,
                 into model: T.Type) -> T? where T : Decodable {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try? decoder.decode(model.self, from: data)
  }
  
  //Universal fetch method for generic requests
  func send<T: APIRequest>(
      _ request: T,
      completion: @escaping ResultCallback<T.Response>) {
 
    let urlRequest = URLRequest(url: request.url())
    session.dataTask(with: urlRequest , completionHandler: { data, response, error in
      guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusOK ,
        let data = data
        else {
          completion(Result.failure(ResponseError.network))
          return
       }
      guard let decoded = self.decode(data: data, into: T.Response.self) else {
        completion(Result.failure(ResponseError.decoding))
        return
       }
      completion(Result.success(decoded))
     }).resume()
  }
}
