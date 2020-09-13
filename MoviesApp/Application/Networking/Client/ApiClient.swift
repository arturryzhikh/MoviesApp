//
//  ApiClient.swift
//  MoviesApp
//
//  Created by Artur Ryzhikh on 13.09.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit
//Protocols
typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

protocol APIClient {
  
  var session: URLSession { get }
  
  func send<T:APIRequest>(_ request: T,
                          completion: @escaping ResultCallback<T.Response>)
  
  func decode<T:Decodable>(data : Data,
                           into model: T.Type) -> T?
  
  
  
  func makeURL(endPoint: String, parameters: [String: String]) -> URL
}

//API Client Class
final class Client: APIClient {

  //FIXME: remove force unwrap
  func makeURL(endPoint: String, parameters: [String : String]) -> URL {
    var urlComponents = URLComponents(string: endPoint)
    let queryItems = [URLQueryItem(name: "api_key", value: API.apiKey)]
    urlComponents?.queryItems = queryItems
    if parameters.isEmpty {
      return urlComponents?.url ?? URL(string: "https://developers.themoviedb.org/3/getting-started/introduction")!
    }
    let additionalQueryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
    urlComponents?.queryItems?.append(contentsOf: additionalQueryItems)
    let url = urlComponents?.url
    return url ?? URL(string: "https://developers.themoviedb.org/3/getting-started/introduction")!
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
 
    let urlRequest = URLRequest(url: makeURL(endPoint: request.endPoint, parameters: request.parameters))
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
