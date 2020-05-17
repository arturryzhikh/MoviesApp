//
//  NetworkService.swift
//  MoviesApp
//
//  Created by Artur R on 13.05.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import Foundation

final class NetworkService {
  
  static let  shared = NetworkService()
  private let apiKey = "be0534e846d5abd01a6b93c899d51676"
  private let baseURL = "https://api.themoviedb.org/3"
  private let searchMoves = "/search/movie"
  private let session = URLSession.shared
  func searchMovies(query: String, completion: @escaping (_ searchMoviesResult: SearchMoviesResult?, _ error: Error?) -> Void ) {
    var urlComponents = URLComponents(string: baseURL + searchMoves )
    var queryItems = [URLQueryItem]()
    queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
    queryItems.append(URLQueryItem(name: "query", value: query))
    urlComponents?.queryItems = queryItems
    guard let url = urlComponents?.url else { return }
    print(url)
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let task = self.session.dataTask(with: request) { (data, response , error) in
        DispatchQueue.main.async {
            guard let data = data,
            let response = response as? HTTPURLResponse,
            (200 ..< 300).contains(response.statusCode),
            error == nil else {
                completion(nil, error)
                return
            }
            let translations =  self.decodeJSON(from: data, into: SearchMoviesResult.self)
            completion(translations,nil)
            }
        }
    task.resume()
    
  }

}
private extension NetworkService {
  func decodeJSON<T:Decodable>(from data: Data?, into model: T.Type) -> T? {
    guard let data = data else {
      print("error decoding JSON into \(model)")
      return nil
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let decodedJSON = try? decoder.decode(T.self, from: data)
    return decodedJSON
  }
}
