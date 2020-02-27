//
//  TabBarController.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence

class TabBarController: UITabBarController  {
    

    private var tabBarPersistance =  DataPersistence<Venue>(filename:"venue.plist")
    private var venues = [Venue]()

    lazy var mapController: MapController =   {
        let viewController = MapController(tabBarPersistance)
        viewController.tabBarItem = UITabBarItem(title: "search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return viewController
        
    }()
    
    lazy var collectionController: AlbumsCollectionsController =   {
        let viewController = AlbumsCollectionsController(tabBarPersistance)
        viewController.tabBarItem = UITabBarItem(title: "collection", image: UIImage(systemName: "folder.badge.plus"), tag: 1)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [mapController, UINavigationController(rootViewController: collectionController)]
    }
}
