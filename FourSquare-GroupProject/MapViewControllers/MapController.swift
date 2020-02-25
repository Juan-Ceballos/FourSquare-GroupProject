//
//  MapController.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {

    let instanceOfMapView = MapView()
    
    private let locationSession = CoreLocationSession()
    
    // this is the instance of the button
    private var userTrackingButton: MKUserTrackingButton!
    

    
    override func loadView() {
        view = instanceOfMapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        instanceOfMapView.avenueMapView.showsUserLocation = true
           
        // where do we want the the button to be 
           //userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 20, y: 20, width: 200, height: 200))
           instanceOfMapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = instanceOfMapView.avenueMapView
           // what does this line mean
           
           
           // set the delegates for both of the text fields...
           instanceOfMapView.searchTheArea.delegate = self
           instanceOfMapView.searchTheKindOfFood.delegate = self
    }
    
    // make a function that will load the data
    
    
    

} // the end of the controller class


extension MapController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
