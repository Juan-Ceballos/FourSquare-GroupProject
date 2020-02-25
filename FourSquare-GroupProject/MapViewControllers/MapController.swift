//
//  MapController.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class MapController: UIViewController {

    let mapView = MapView()
    
    private let locationSession = CoreLocationSession()
    
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        mapView.avenueMapView.showsUserLocation = true
      mapView.foodCollectionView.dataSource = self
      mapView.foodCollectionView.delegate = self
      mapView.foodCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "mapCell")
        //NSLocationAlwaysAndWhenInUseUsageDescription
        //NSLocationWhenInUseUsageDescription
    }

}

extension MapController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath)
    cell.backgroundColor = .systemBlue
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
}

extension MapController : UICollectionViewDelegateFlowLayout {
  
}
