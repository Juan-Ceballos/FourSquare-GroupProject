# FourSquare-GroupProject
Allows users to search for food venues based on location, and what they're craving. Users' preferred venues may be added to a personal collection.

![Dependencies](https://img.shields.io/badge/dependencies-up%20to%20date-brightgreen) ![AppVeyor](https://img.shields.io/badge/build-passing-brightgreen)

## Installation

### Prerequisites

* A developer account from [Foursquare](https://foursquare.com/) for an API key composed of a Client Id and Client Secret

### Clone

* Clone this repo to your local machine using `https://github.com/Juan-Ceballos/FourSquare-GroupProject.git`

### Setup

* Add a Swift file named Config to project directory.
* in file add following code
```swift
struct ApiKey {
  static let clientID = "\*Your Foursquare Client Id\*"
  static let clientSecret = "\*Your Foursquare Client Secret\*"
}```

## Features

* Search for food venues based on location
* Get Info on venue such as directions, venue photo
* Delivery if available directly from venue page
* Create personal collection of favorite venues, and add to existing collection

## Built With

* Xcode 11.4
* Swift 5.2
* Safari Services
* MapKit

## Collaborators
[Shaniya Suwagboe](https://github.com/suwagboe)

[Luba Kaper](https://github.com/LubaKaper)

[Eric Davenport](https://github.com/EricDavenport)

[Juan Ceballos](https://github.com/Juan-Ceballos)
