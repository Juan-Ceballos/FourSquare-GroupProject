//
//  PhotoAPIClient.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import Foundation
import NetworkHelper

struct PhotoAPIClient {

  static func photoURL(venueID: String, completion: @escaping (Result<String, AppError>) -> ()) {
    let endpoint = "https://api.foursquare.com/v2/venues/4aa52d50f964a520834720e3/photos?client_id=\(ApiKey.clientID)&client_secret=\(ApiKey.clientSecret)"
    
    guard let url = URL(string: endpoint) else {
      completion(.failure(.badURL(endpoint)))
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let result = try JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
        } catch {
          
        }
      }
    }
  }
}

//
//struct FourSquareAPIClient {
//    static func getVenues(for near: String, query: String, completion: @escaping (Result<[Venue], AppError>) ->()) {
//
//        let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "sushi"
//        let near = near.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "brooklyn"
//        let enpointURLString = "https://api.foursquare.com/v2/venues/search?client_id=\(ApiKey.clientID)&client_secret=\(ApiKey.clientSecret)&v=20190208&near=\(near)&query=\(query)"
//
//        guard let url = URL(string: enpointURLString) else {
//            completion(.failure(.badURL(enpointURLString)))
//            return
//        }
//        let request = URLRequest(url: url)
//
//        NetworkHelper.shared.performDataTask(with: request) { (result) in
//            switch result {
//            case .failure(let error):
//                completion(.failure(.networkClientError(error)))
//            case .success(let data):
//                do {
//                    let searchResults = try JSONDecoder().decode(Data.self, from: data)
//                    let venues = searchResults.response.venues
//                    completion(.success(venues))
//                } catch {
//                    completion(.failure(.decodingError(error)))
//                }
//            }
//        }
//    }
//}
