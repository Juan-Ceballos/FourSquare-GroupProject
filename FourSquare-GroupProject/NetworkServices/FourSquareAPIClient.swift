//
//  FourSquareAPIClient.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import Foundation
import NetworkHelper

struct Data: Codable & Equatable {
    let response: Response
}

struct Response: Codable & Equatable {
    let venues: [Venue]
}

struct Venue: Codable & Equatable {
    let id: String
    let name: String
    let location: Location
    let categories: [Category]
    let hasPerk: Bool
    let delivery: Delivery?
}

struct Location: Codable & Equatable {
    let address: String
    let lat: Double
    let lng: Double
    let postalCode: String
    let city: String
    let state: String
    let country: String
    let formattedAddress: [String]
    let neighborhood: String?
    let crossStreet: String?
}
struct Category: Codable & Equatable {
    let shortName: String
}

struct Delivery: Codable & Equatable {
    let id: String
    let url: String
    let provider: Provider
}

struct Provider: Codable & Equatable{
    let name: String
    //let icon: ProviderIcon
}

struct FourSquareAPIClient {
    static func getVenues(for near: String, query: String, completion: @escaping (Result<[Venue], AppError>) ->()) {
        
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "sushi"
        let near = near.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "brooklyn"
        let enpointURLString = "https://api.foursquare.com/v2/venues/search?client_id=\(ApiKey.clientID)&client_secret=\(ApiKey.clientSecret)&v=20190208&near=\(near)&query=\(query)"
        
        guard let url = URL(string: enpointURLString) else {
            completion(.failure(.badURL(enpointURLString)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(.networkClientError(error)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(Data.self, from: data)
                    let venues = searchResults.response.venues
                    completion(.success(venues))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}

