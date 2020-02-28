//
//  RestaurantsDetailController.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import SafariServices
import DataPersistence
import MapKit

class RestaurantsDetailController: UIViewController {
    
    private let locationSession = CoreLocationSession()
    private var annotation = MKPointAnnotation()
    private var isShowingNewAnnotations = false
    
    private var restaurantDetailView = RestaurantsDetailView()
    
    private var dataPersistence: DataPersistence<Venue>
    private var selectedVenue: Venue
    
    init(_ dataPersistence: DataPersistence<Venue>, _ selectedVenue: Venue){
        self.dataPersistence = dataPersistence
        
        self.selectedVenue = selectedVenue
        super.init(nibName: nil, bundle: nil)
        self.dataPersistence.delegate = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coser:) has  not been implemented")
    }
    
    override func loadView() {
        
        view = restaurantDetailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        restaurantDetailView.map.showsUserLocation = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(saveButtonPressed))
        
        restaurantDetailView.deliveryButton.addTarget(self, action: #selector(deliveryButton(_:)), for: .touchUpInside)
        
        navigationItem.title = selectedVenue.name
        
        restaurantDetailView.map.delegate = self
        
        
        updateUI()
        loadMap()
        
    }
    
    private func loadMap() {
        let annotation = makeAnnotation(for: selectedVenue)
        restaurantDetailView.map.addAnnotation(annotation)
        getDirections()
    }
    
    private func makeAnnotation(for venue: Venue) -> MKPointAnnotation {
        selectedVenue = venue
        let annotation = MKPointAnnotation()
        
        let coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
        annotation.title = venue.name
        annotation.coordinate = coordinate
        
        isShowingNewAnnotations = true
        self.annotation = annotation
        return annotation
    }
    
    private func getDirections() {
        let coordinate = CLLocationCoordinate2D(latitude: selectedVenue.location.lat, longitude: selectedVenue.location.lng)
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        request.transportType = .any
        let directions = MKDirections(request: request)
        directions.calculate { [unowned self](response, error) in
            guard let unwrappedResponse = response else { return }
            for route in unwrappedResponse.routes {
                self.restaurantDetailView.map.addOverlay(route.polyline)
                self.restaurantDetailView.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    @objc private func saveButtonPressed() {
        print("save pressed")
        
        if dataPersistence.hasItemBeenSaved(selectedVenue) {
            showAlert(title: "Ooops!", message: "This place was already saved to your collections!")
        } else {
            do {

                try dataPersistence.createItem(selectedVenue)
                showAlert(title: "Yay!", message: "New Great Place was Saved to Your Collection!")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    self.dismiss(animated: true)
                    let addCollVC = AddCollectionController(self.dataPersistence, venue: self.selectedVenue)
                    //              let adetailVC = UINavigationController(rootViewController: addCollVC)
                                   // present(adetailVC,animated: true)
                                  //present(adetailVC, animated: true)
                    self.navigationController?.pushViewController(addCollVC, animated: true)
                }
                
            } catch {
                showAlert(title: "Error", message: "Sorry, we were unable to save this venue.")
            }
        }
    }
    
    @objc private func deliveryButton(_ sender: UIButton) {
        guard let urlString = selectedVenue.delivery?.url else {
            showAlert(title: "Oops", message: "This place does not deliver")
            return
        }
        let safariVC = SFSafariViewController(url: URL(string: urlString)!)
        present(safariVC, animated: true)
    }
    
    
    private func updateUI() {
        
        restaurantDetailView.venueNameLabel.text = selectedVenue.name
        restaurantDetailView.venueAddressLabel.text = selectedVenue.location.formattedAddress.joined(separator: ", ")
        
        PhotoAPIClient.photoURL(venue: selectedVenue) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.restaurantDetailView.venueImage.image = UIImage(named: "exclamationmark - octagon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.restaurantDetailView.venueImage.getImage(with: image, completion: { (result) in
                        switch result {
                        case .failure:
                            print("fail")
                        case .success(let image):
                            self?.restaurantDetailView.venueImage.image = image
                        }
                    })
                }
            }
        }
        
    }
    
}

extension UIViewController {
    func showAlert(title: String?, message: String?, completion: ((UIAlertAction) ->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default, handler: completion)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension RestaurantsDetailController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.tintColor = .black
            annotationView?.markerTintColor = .systemRed
            
        } else {
            annotationView?.annotation = annotation
           // annotationView?.canShowCallout = true
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        // renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
        renderer.strokeColor = UIColor.systemBlue
        
        renderer.lineWidth = 3.0
        
        // renderer.lineDashPattern = [10]
        
        return renderer
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if isShowingNewAnnotations {
            restaurantDetailView.map.showAnnotations([annotation], animated: false)
        }
        isShowingNewAnnotations = false
    }
}
extension RestaurantsDetailController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        updateUI()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        updateUI()
    }
    
    
}
