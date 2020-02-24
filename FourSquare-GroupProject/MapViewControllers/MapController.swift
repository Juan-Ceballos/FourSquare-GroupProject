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
        //NSLocationAlwaysAndWhenInUseUsageDescription
        //NSLocationWhenInUseUsageDescription
    }

}
