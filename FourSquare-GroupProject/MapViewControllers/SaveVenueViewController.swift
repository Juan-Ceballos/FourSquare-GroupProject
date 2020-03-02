//
//  SaveVenueViewController.swift
//  FourSquare-GroupProject
//
//  Created by Liubov Kaper  on 2/28/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence

class SaveVenueViewController: UIViewController {
    
    let instanceOfSaveVenue = SaveVenueView()
    
    private var dataPersistence: DataPersistence<AlbumCollection>
    private var savedVenue: Venue
    
    init(_ dataPersistence: DataPersistence<AlbumCollection>, _ savedVenue: Venue){
        self.dataPersistence = dataPersistence
        self.savedVenue = savedVenue
        super.init(nibName: nil, bundle: nil)
        
    }
 
    
    required init(coder: NSCoder) {
        fatalError("init(coser:) has  not been implemented")
    }
    
    
    override func loadView() {
        view = instanceOfSaveVenue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        instanceOfSaveVenue.delegate = self
       
    }
    

}

extension SaveVenueViewController: ANewCollectionDelegate {
    
    
    func segueToAddNewCollectionController() {
        
         guard let aVenue = savedVenue as? Venue else {
                    print("there are no venues")
                    return
                }
        
       // let newAlbum = AlbumCollection(title: "", arrVenues: [aVenue], image: Photos?)
                
                let instance = AddCollectionController(dataPersistence, venue: aVenue)
      
              //  present(instance,animated: true)
               // push(instance, animated: true)
        
                //UINavigationController.pushViewController(rootViewContrller: instance)
//               let thing = UINavigationController.init(rootViewController: instance)
            //   navigationController?.pushViewController(instance, animated: true)
//                       navigationController?.pushViewController(instance, animated: true)
        present(instance, animated: true, completion: nil)
        
      //  navigationController?.present(instance, animated: true, completion: nil)
        
    }
    
  func checkTheMadeCollections() {
   let aVenue = savedVenue
    let instance = CollectionListViewController(dataPersistence, venue: aVenue)
    present(instance, animated: true, completion: nil)

    
    
    
  }
    
}
