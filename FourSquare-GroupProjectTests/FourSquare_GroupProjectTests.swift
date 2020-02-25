//
//  FourSquare_GroupProjectTests.swift
//  FourSquare-GroupProjectTests
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import XCTest
import NetworkHelper
@testable import FourSquare_GroupProject




class ForsquareProjectBackupTests: XCTestCase {
  
  
  func testFSModel() {
    
    struct Data: Codable & Equatable {
      let response: Response
    }
    
    struct Response: Codable & Equatable {
      let venues: [Venue]
    }
    
    struct Venue: Codable & Equatable {
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
    
    let json = """
        {
            "meta": {
                "code": 200,
                "requestId": "5e5149f6b1cac0001b4943bb"
            },
            "response": {
                "venues": [
                    {
                        "id": "4be09b7fcb81c9b62069668b",
                        "name": "Sushi Tokyo",
                        "location": {
                            "address": "1360 Coney Island Ave",
                            "crossStreet": "at Ave J",
                            "lat": 40.624331415304596,
                            "lng": -73.96511435680407,
                            "labeledLatLngs": [
                                {
                                    "label": "display",
                                    "lat": 40.624331415304596,
                                    "lng": -73.96511435680407
                                }
                            ],
                            "postalCode": "11230",
                            "cc": "US",
                            "city": "Brooklyn",
                            "state": "NY",
                            "country": "United States",
                            "formattedAddress": [
                                "1360 Coney Island Ave (at Ave J)",
                                "Brooklyn, NY 11230",
                                "United States"
                            ]
                        },
                        "categories": [
                            {
                                "id": "4bf58dd8d48988d1d2941735",
                                "name": "Sushi Restaurant",
                                "pluralName": "Sushi Restaurants",
                                "shortName": "Sushi",
                                "icon": {
                                    "prefix": "https://ss3.4sqi.net/img/categories_v2/food/sushi_",
                                    "suffix": ".png"
                                },
                                "primary": true
                            }
                        ],
                        "delivery": {
                            "id": "369422",
                            "url": "https://www.seamless.com/menu/sushi-tokyo-1360-coney-island-ave-brooklyn/369422?affiliate=1131&utm_source=foursquare-affiliate-network&utm_medium=affiliate&utm_campaign=1131&utm_content=369422",
                            "provider": {
                                "name": "seamless",
                                "icon": {
                                    "prefix": "https://fastly.4sqi.net/img/general/cap/",
                                    "sizes": [
                                        40,
                                        50
                                    ],
                                    "name": "/delivery_provider_seamless_20180129.png"
                                }
                            }
                        },
                        "referralId": "v-1582385709",
                        "hasPerk": false
                    },
                    {
                        "id": "5276d39a498eb1a5d90096e4",
                        "name": "Sushi Katsuei",
                        "location": {
                            "address": "210 7th Ave",
                            "crossStreet": "at 3rd St",
                            "lat": 40.67061519402922,
                            "lng": -73.97850388946965,
                            "labeledLatLngs": [
                                {
                                    "label": "display",
                                    "lat": 40.67061519402922,
                                    "lng": -73.97850388946965
                                }
                            ],
                            "postalCode": "11215",
                            "cc": "US",
                            "city": "Brooklyn",
                            "state": "NY",
                            "country": "United States",
                            "formattedAddress": [
                                "210 7th Ave (at 3rd St)",
                                "Brooklyn, NY 11215",
                                "United States"
                            ]
                        },
                        "categories": [
                            {
                                "id": "4bf58dd8d48988d111941735",
                                "name": "Japanese Restaurant",
                                "pluralName": "Japanese Restaurants",
                                "shortName": "Japanese",
                                "icon": {
                                    "prefix": "https://ss3.4sqi.net/img/categories_v2/food/japanese_",
                                    "suffix": ".png"
                                },
                                "primary": true
                            }
                        ],
                        "referralId": "v-1582385709",
                        "hasPerk": false
                    },
                    {
                        "id": "4f415376e4b08cc37282ff20",
                        "name": "Whole Foods Sushi Bar",
                        "location": {
                            "address": "Whole Foods Market",
                            "lat": 40.72399989837209,
                            "lng": -73.99227661853082,
                            "labeledLatLngs": [
                                {
                                    "label": "display",
                                    "lat": 40.72399989837209,
                                    "lng": -73.99227661853082
                                }
                            ],
                            "postalCode": "10012",
                            "cc": "US",
                            "city": "New York",
                            "state": "NY",
                            "country": "United States",
                            "formattedAddress": [
                                "Whole Foods Market",
                                "New York, NY 10012",
                                "United States"
                            ]
                        },
                        "categories": [
                            {
                                "id": "4bf58dd8d48988d1d2941735",
                                "name": "Sushi Restaurant",
                                "pluralName": "Sushi Restaurants",
                                "shortName": "Sushi",
                                "icon": {
                                    "prefix": "https://ss3.4sqi.net/img/categories_v2/food/sushi_",
                                    "suffix": ".png"
                                },
                                "primary": true
                            }
                        ],
                        "referralId": "v-1582385709",
                        "hasPerk": false
                    },
                    {
                        "id": "4c67509b8e9120a17aa4da64",
                        "name": "Sushi Meshuga",
                        "location": {
                            "address": "1637 E 17th St",
                            "lat": 40.60985805551766,
                            "lng": -73.95656241796279,
                            "labeledLatLngs": [
                                {
                                    "label": "display",
                                    "lat": 40.60985805551766,
                                    "lng": -73.95656241796279
                                }
                            ],
                            "postalCode": "11229",
                            "cc": "US",
                            "city": "Brooklyn",
                            "state": "NY",
                            "country": "United States",
                            "formattedAddress": [
                                "1637 E 17th St",
                                "Brooklyn, NY 11229",
                                "United States"
                            ]
                        },
                        "categories": [
                            {
                                "id": "4bf58dd8d48988d1d2941735",
                                "name": "Sushi Restaurant",
                                "pluralName": "Sushi Restaurants",
                                "shortName": "Sushi",
                                "icon": {
                                    "prefix": "https://ss3.4sqi.net/img/categories_v2/food/sushi_",
                                    "suffix": ".png"
                                },
                                "primary": true
                            }
                        ],
                        "delivery": {
                            "id": "1137114",
                            "url": "https://www.seamless.com/menu/sushi-meshuga-1637-e-17th-st-brooklyn/1137114?affiliate=1131&utm_source=foursquare-affiliate-network&utm_medium=affiliate&utm_campaign=1131&utm_content=1137114",
                            "provider": {
                                "name": "seamless",
                                "icon": {
                                    "prefix": "https://fastly.4sqi.net/img/general/cap/",
                                    "sizes": [
                                        40,
                                        50
                                    ],
                                    "name": "/delivery_provider_seamless_20180129.png"
                                }
                            }
                        },
                        "referralId": "v-1582385709",
                        "hasPerk": false
                    }
                    
                ],
                "geocode": {
                    "what": "",
                    "where": "brooklyn",
                    "feature": {
                        "cc": "US",
                        "name": "Brooklyn",
                        "displayName": "Brooklyn, NY, United States",
                        "matchedName": "Brooklyn, NY, United States",
                        "highlightedName": "<b>Brooklyn</b>, NY, United States",
                        "woeType": 9,
                        "id": "geonameid:6941775",
                        "longId": "72057594044869711",
                        "geometry": {
                            "center": {
                                "lat": 40.63439,
                                "lng": -73.95027
                            },
                            "bounds": {
                                "ne": {
                                    "lat": 40.739446,
                                    "lng": -73.833365
                                },
                                "sw": {
                                    "lat": 40.551041999999995,
                                    "lng": -74.05663
                                }
                            }
                        }
                    },
                    "parents": []
                }
            }
        }
        
        """.data(using: .utf8)!
    
    // act
    let venues = try! JSONDecoder().decode(Data.self, from: json)
    // assert
    XCTAssertEqual(venues.response.venues.count, 4)
    
  }
  
  func testRestaurantFound() {
    // arrange
    let name = "Sushi Tokyo"
    let exp = XCTestExpectation(description: "search found")
    
    // act
    FourSquareAPIClient.getVenues(for: "brooklyn", query: "sushi") { (result) in
      switch result {
      case .failure:
        XCTFail()
      case .success(let venues):
        exp.fulfill()
        XCTAssertEqual(venues.first?.name, name)
      }
    }
    wait(for: [exp], timeout: 5.0)
    
  }
  
  
  
  
  // MARK: - Welcome
  struct Results: Codable & Equatable {
      let response: Response
  }

  // MARK: - Response
  struct Response: Codable & Equatable {
      let photos: Photos
  }

  // MARK: - Photos
  struct Photos: Codable & Equatable {
      let count: Int
      let items: [Item]
      let dupesRemoved: Int
  }

  // MARK: - Item
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
  
  func testPrefix() {
  let data =
  """
    {
    "meta": {
        "code": 200,
        "requestId": "5e543f280de0d9001bcd64d7"
    },
    "response": {
        "photos": {
            "count": 1,
            "items": [
                {
                    "id": "5160412c498e09c17d7b87e4",
                    "createdAt": 1365262636,
                    "source": {
                        "name": "Instagram",
                        "url": "http://instagram.com"
                    },
                    "prefix": "https://fastly.4sqi.net/img/general/",
                    "suffix": "/82007_cHf3A0muNVwivg_w1lfjVMkU7K99xN1txQwb2TjWC6E.jpg",
                    "width": 612,
                    "height": 612,
                    "user": {
                        "id": "82007",
                        "firstName": "Pares",
                        "lastName": "T",
                        "photo": {
                            "prefix": "https://fastly.4sqi.net/img/user/",
                            "suffix": "/82007-OAAO2XEQHIPR3NQZ.jpg"
                        }
                    },
                    "checkin": {
                        "id": "5160412a498eedc7cc9f8f03",
                        "createdAt": 1365262634,
                        "type": "checkin",
                        "timeZoneOffset": -240
                    },
                    "visibility": "public"
                }
            ],
            "dupesRemoved": 0
        }
    }
      }


  """.data(using: .utf8)!
  
  let expPrefix = "https://fastly.4sqi.net/img/general/"
  
  do {
  let result = try JSONDecoder().decode(Results.self, from: data)
    let info = result.response.photos.items
    let url = info.first?.itemPrefix
    XCTAssertEqual(expPrefix, url)
  } catch {
  XCTFail("error: \(error)")
  }
  
}
}


