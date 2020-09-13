//
//  ApiClient.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation

typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

protocol APIClient {
 func send<T:APIRequest>(_ request: T,
                          completion: @escaping ResultCallback<T.Response>)
}

final class Client: APIClient {
  func send<T: APIRequest>(
      _ request: T,
      completion: @escaping ResultCallback<T.Response>) {
 
    let urlRequest = URLRequest(url: request.url())
    let session = URLSession.shared
    session.dataTask(with: urlRequest , completionHandler: { data, response, error in
      guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusOK ,
        let data = data
        else {
          completion(Result.failure(ResponseError.network))
          return
       }
      guard let decoded = try? JSONDecoder().decode(T.Response.self, from: data) else {
        completion(Result.failure(ResponseError.decoding))
        return
       }
      completion(Result.success(decoded))
     }).resume()
  }
}
