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
    
    var region: MKCoordinateRegion?
  
  var mapView = MKMapView()
    
    private var isShowingAnnoations = false
    
    private var annotations = [MKPointAnnotation]()

    // this is the instance of the button
    private var userTrackingButton: MKUserTrackingButton!
    

    override func loadView() {
        view = instanceOfMapView
    }
    
    private var allVenues = [Venue]()
    {
        didSet {
            DispatchQueue.main.async {
                self.loadMap()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        instanceOfMapView.actualMapView.showsUserLocation = true
        // where do we want the the button to be 
           //userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 20, y: 20, width: 200, height: 200))
          // instanceOfMapView.addSubview(userTrackingButton)
      //  userTrackingButton.mapView = instanceOfMapView.avenueMapView
           // what does this line mean
        instanceOfMapView.foodCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "venuesCell")
           
        // MARK: how to dismiss keyboard when user touchs screen
    
        // delegeate for the map
        instanceOfMapView.actualMapView.delegate = self
        
           // set the delegates for both of the text fields...
           instanceOfMapView.searchTheArea.delegate = self
           instanceOfMapView.searchTheKindOfFood.delegate = self
        
        // access to user location
        instanceOfMapView.actualMapView.showsUserLocation = true
        
//        weak var delegate = instanceOfMapView
        instanceOfMapView.delegate = self
        
        // delegated for collection view
        instanceOfMapView.foodCollectionView.delegate = self
      mapView.delegate = self
        loadMap()
   
    }
    
    // make a function that will load the venues
    private func loadTheVenuesOnTheMap(Thearea area: String, specficItem food: String){
         //   let area = instanceOfMapView.searchTheArea
       // let stuff = instanceOfMapView.searchTheKindOfFood
        FourSquareAPIClient.getVenues(for: area , query: food ) { [weak self]
            (result) in
            switch result {
            case .failure(let error):
                print("the error is \(error)")
            case .success(let info):
                self?.allVenues = info
            }
        }
    }
    
    func loadMap() {
        let annotations = makeAnnotations()
        instanceOfMapView.actualMapView.addAnnotations(annotations)
    }
    
    public func makeAnnotations() -> [MKPointAnnotation] {
        var annotationsInSideOfFunction = [MKPointAnnotation]()
        for venue in allVenues {
            // I have access to the coordinates here so it makes sense to set the region as well.
            let coordinates = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
            
            let annotation = MKPointAnnotation()
            annotation.title = venue.name
            annotation.coordinate = coordinates
            annotationsInSideOfFunction.append(annotation)
            
            let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 3000, longitudinalMeters: 3000)
            self.instanceOfMapView.actualMapView.setRegion(region, animated: true)
        }
        isShowingAnnoations = true
        self.annotations = annotationsInSideOfFunction
        return annotationsInSideOfFunction
    }
    
} // the end of the controller class

// MARK: Collection DataSource
extension MapController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allVenues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "venuesCell", for: indexPath)
        cell.backgroundColor = .white
        
        return cell
    }
    
    
}

//MARK: DelegateFlowLayout
extension MapController: UICollectionViewDelegateFlowLayout{
    
}



// MARK: text field delegate
extension MapController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
       print("textFieldDidBeginEditing")
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection")
        
        
//        guard instanceOfMapView.searchTheKindOfFood.text!.isEmpty || instanceOfMapView.searchTheArea.text!.isEmpty else {
//            print("the values of this are now found to be empty.")
//            return
//        }

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
//        guard instanceOfMapView.searchTheKindOfFood.text!.isEmpty && instanceOfMapView.searchTheArea.text!.isEmpty else {
//          //  instanceOfMapView.foodCollectionView.
//        }
        
        guard let area = instanceOfMapView.searchTheArea.text , let food = instanceOfMapView.searchTheKindOfFood.text else {
                   //query(Thearea: area, specficItem: food)
                 fatalError("something is wrong with the text field.. double check inside of the textFieldShouldReturn")
               }
                       print("\(area) + \(food)")
        

              loadTheVenuesOnTheMap(Thearea: area, specficItem: food)

        textField.resignFirstResponder()
        return true
    }
    
}

// MARK:map delegate
extension MapController: MKMapViewDelegate {
    
    // why are my annotations not purple??
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // this is to get the makers
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "thisStuff is ugly!!!!"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.glyphTintColor = .systemPurple
            annotationView?.glyphImage = UIImage(named: "")
            annotationView?.markerTintColor = .white
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        // when they school the query function should get called and it should update the map of the search item...
        print("SHANIYA ITS MOVING because: mapViewDidChangeVisibleRegion ")
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        print("SHANIYA ITS MOVING because: regionDidChangeAnimated ")

    }
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        print("the users location can NOW be found - mapViewWillStartLocatingUser")
    }
    
    
}

// extension for the pressed button
extension MapController: SearchDelegate {
    func listenForButtonPressed(_ MapView: MapView, venues: [Venue]) {
        
        guard let searchedVenues = allVenues as? [Venue] else {
            print("there are no venues")
            return
        }
        
        let instance = ResultsOfSearchController(searchedVenues)
        
        present(instance,animated: true)
       // push(instance, animated: true)

      //  UINavigationController.pushViewController(instance)
    }
}

