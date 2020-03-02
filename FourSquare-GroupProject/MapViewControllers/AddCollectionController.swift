//
//  MapAndSearchController.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence

protocol AddCollectionGroupDelegate: AnyObject {
    func addGroup(group: AlbumCollection)
}

class AddCollectionController: UIViewController {
    
    weak var delegate: AddCollectionGroupDelegate?
    
    var venue: Venue!
    
    private var dataPersistence: DataPersistence<AlbumCollection>
    
    //private var secondDataPer = DataPersistence<AlbumCollection>(filename: "collections.plist")
    
    init(_ dataPersistence:DataPersistence<AlbumCollection>, venue: Venue?) {
        self.venue = venue
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coser:) has  not been implemented")
    }
    
    private let addCollectionView = AddCollectionView()
    
    private var collection: AlbumCollection?
    
    private var keyForCollection: String?
    
    private var emptyVenue = [Venue]()
    
    override func loadView() {
        view = addCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
      print(venue)
        configureNavBar()
        addCollectionView.namingTextField.delegate = self
    }
    
    private func configureNavBar()  {
        self.title = "Add to or Create Collection"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xButtonPressed))
        
        addCollectionView.createButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
    }
    
    @objc private func xButtonPressed()   {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func createButtonPressed()  {
        // guard
        print("pressed")
        print(addCollectionView.namingTextField.text ?? "Not working yet")
        
        let title = addCollectionView.namingTextField.text ?? "Not working yet"
      // TODO: guard against empty venue
      emptyVenue.append(venue)
        collection = AlbumCollection(title: title, arrVenues: emptyVenue, image: nil)
        
        delegate?.addGroup(group: collection!)
        print(collection!.title)
        print(collection!.title)
      let title2 = addCollectionView.namingTextField.text
      collectionMade(title: title2 ?? "Fake collection", venue: venue)
        createCollection(newCollection: collection!)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func createCollection(newCollection: AlbumCollection)    {
        do  {
            //try secondDataPer.createItem(newCollection)
            try dataPersistence.createItem(newCollection)
            print("success")
        }
        catch   {
            print("fail")
        }
    }
  
  private func collectionMade(title: String, venue: Venue) {
    var array = [Venue]()
    array.append(venue)
    let collection = AlbumCollection(title: title, arrVenues: array, image: nil)
    do {
      try dataPersistence.createItem(collection)
      print("venue saved")
    } catch {
      print("failed to saaved venue with collection")
    }
  }
    
}

extension AddCollectionController: UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

