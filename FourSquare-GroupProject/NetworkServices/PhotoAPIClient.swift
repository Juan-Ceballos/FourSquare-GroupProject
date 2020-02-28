//
//  PhotoAPIClient.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import Foundation
import NetworkHelper


struct Results : Codable & Equatable {
  let response : Response2
}

 struct Response2: Codable & Equatable {
     let photos: Photos
 }

 struct Photos: Codable & Equatable {
     let count: Int
     let items: [Item]
     let dupesRemoved: Int
 }

 struct Item: Codable & Equatable {
     let id: String
     let createdAt: Int
     let itemPrefix: String
     let suffix: String
     let width, height: Int
     let visibility: String

     enum CodingKeys: String, CodingKey {
         case id, createdAt
         case itemPrefix = "prefix"
         case suffix, width, height, visibility
     }
 }

struct PhotoAPIClient {

  static func photoURL(venue: Venue, completion: @escaping (Result<String, AppError>) -> ()) {
    let endpoint = "https://api.foursquare.com/v2/venues/\(venue.id)/photos?client_id=\(ApiKey.clientID)&client_secret=\(ApiKey.clientSecret)&v=20200201"
    
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
          let result = try JSONDecoder().decode(Results.self, from: data)
          let info = result.response.photos.items
            
            guard let pref = info.first?.itemPrefix else {
                print("pref - this is wrong")
                return
            }
            
            guard let suf = info.first?.suffix else {
                print("info.first?.suffix is WRONG")
                return
            }
          let url = "\(pref)300x300\(suf)"
          completion(.success(url))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
}
