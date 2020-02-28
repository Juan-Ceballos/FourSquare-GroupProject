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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
       
    }
    

   

}
