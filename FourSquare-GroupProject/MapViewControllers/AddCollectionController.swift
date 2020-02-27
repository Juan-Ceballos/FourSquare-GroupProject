//
//  MapAndSearchController.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence

class AddCollectionController: UIViewController {
    // instance of data persistence
    
    private var dataPersistence: DataPersistence<Venue>?
    
    private let addCollectionView = AddCollectionView()
    
    override func loadView() {
        view = addCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
    }
    
    private func configureNavBar()  {
        self.title = "Add to or Create Collection"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xButtonPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createButtonPressed))
    }
    
    @objc private func xButtonPressed()   {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func createButtonPressed()  {
        print("pressed")
    }

}
