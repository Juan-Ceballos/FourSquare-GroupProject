//
//  TabBarController.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController  {
    
    lazy var mapController: MapController =   {
        let viewController = MapController()
        viewController.tabBarItem = UITabBarItem(title: "search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return viewController
        
    }()
    
    lazy var collectionController: CollectionController =   {
        let viewController = CollectionController()
        viewController.tabBarItem = UITabBarItem(title: "collection", image: UIImage(systemName: "folder.badge.plus"), tag: 1)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [mapController, collectionController]
    }
}
