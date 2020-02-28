//
//  MapController.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import MapKit
import DataPersistence

class MapController: UIViewController {

    let instanceOfMapView = MapView()
    
    private let locationSession = CoreLocationSession()
    
    private let dp: DataPersistence<AlbumCollection>
      init(_ dataPersistence:DataPersistence<AlbumCollection>) {
          self.dp = dataPersistence
          super.init(nibName: nil, bundle: nil)
      }
      required init?(coder: NSCoder) {
          fatalError("init(coser:) has  not been implemented")
      }
    
    
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
                self.instanceOfMapView.foodCollectionView.reloadData()
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
        
           
        // MARK: how to dismiss keyboard when user touchs screen
    
        // stuff for the map
        instanceOfMapView.actualMapView.delegate = self
        // access to user location
        instanceOfMapView.actualMapView.showsUserLocation = true
        //  weak var delegate = instanceOfMapView
           instanceOfMapView.delegate = self
        
        // set the delegates for both of the text fields...
           instanceOfMapView.searchTheArea.delegate = self
           instanceOfMapView.searchTheKindOfFood.delegate = self
        
        // delegated for collection view
        instanceOfMapView.foodCollectionView.delegate = self
        instanceOfMapView.foodCollectionView.dataSource = self
        instanceOfMapView.foodCollectionView.register(mapCell.self, forCellWithReuseIdentifier: "venuesCell")
        
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
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "venuesCell", for: indexPath) as? mapCell else {
            fatalError("cell doesnt work")
        }
        let venue = allVenues[indexPath.row]
        
        cell.configureCell(for: venue)
        
        return cell
    }
    
    
}

//MARK: DelegateFlowLayout
extension MapController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // this is where you return the actual size of the cell.
           let maxSize: CGSize = UIScreen.main.bounds.size
           let itemWidth: CGFloat = maxSize.width
           // MARK: this is to change the height of the cell
           let itemHeight: CGFloat = maxSize.height * 0.20 // make it 30%
           return CGSize(width: itemWidth, height: itemHeight)
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
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
        
        let instance = ResultsOfSearchController(dp, searchedVenues)
        
      //  present(instance,animated: true)
       // push(instance, animated: true)

        //UINavigationController.pushViewController(rootViewContrller: instance)
//        let thing = UINavigationController.init(rootViewController: instance)
//        navigationController?.pushViewController(thing, animated: true)
               navigationController?.pushViewController(instance, animated: true)
    }
    
}
