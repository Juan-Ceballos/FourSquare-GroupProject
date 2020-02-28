//
//  CollectionControllers.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence

class AlbumsCollectionsController: UIViewController {
    
    // didselect collection view, opens up venues
    // saving new albumscollection, load {do catch} load data
    //
    
    private let dp: DataPersistence<AlbumCollection>
    private var secondDataPer = DataPersistence<AlbumCollection>(filename: "collections.plist")

    init(_ dataPersistence:DataPersistence<AlbumCollection>) {
        self.dp = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coser:) has  not been implemented")
    }

    //passing collection name, 0 venues
    let collectionView = CollectionView()
    
    // make a singleton
    var collections = [AlbumCollection](){
        didSet{
            collectionView.collections.reloadData()
          if collections.isEmpty {
            collectionView.collections.backgroundView = EmptyView(title: "Empty", message: "Please add to fill")
          } else {
            collectionView.collections.backgroundView = nil
          }
        }
    }
    
    override func loadView() {
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        collectionView.collections.register(SearchResultsCell.self, forCellWithReuseIdentifier: "searchResultCell")
        collectionView.collections.dataSource = self
        collectionView.collections.delegate = self
        dp.delegate = self
        secondDataPer.delegate = self
        configureNavBar()
        loadCollections()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //loadCollections()
    }
    
    
    private func loadCollections() {
        do {
            collections = try secondDataPer.loadItems()
        } catch {
            print(error)
        }
    }
    
    private func configureNavBar()  {
        self.navigationItem.title = "My Collection"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pressButton))
    }
    
    @objc private func pressButton()  {
        let addCollectionController = AddCollectionController(dp, venue: nil)
        navigationController?.pushViewController(addCollectionController, animated: true)
        addCollectionController.delegate = self
    }
    
}

extension AlbumsCollectionsController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchResultCell", for: indexPath) as? SearchResultsCell
            else    {
                fatalError()
        }
        
        cell.configureCellEmpty(for: collections[indexPath.row])
        cell.backgroundColor = .green
        return cell
    }
    
}

extension AlbumsCollectionsController: UICollectionViewDelegateFlowLayout    {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = CGSize(width: 200, height: 200)
        return itemSize
//        let itemSpacing: CGFloat = 0.1
//        let maxWidth = UIScreen.main.bounds.size.width
//        let numberOfItems: CGFloat = 3
//        let totalSpace: CGFloat = numberOfItems * itemSpacing
//        let itemWidth: CGFloat = (maxWidth - totalSpace) / 1
//        return CGSize(width: itemWidth/2, height: itemWidth/1.5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("pressed")
        //let albums = AlbumsCollectionsController(secondDataPer)
        
        let collection = collections[indexPath.row].arrVenues
        
        let aCollection = ACollectionController(secondDataPer, venue: collection)
        
        if collection.isEmpty  {
            print("Empty")
          navigationController?.pushViewController(aCollection, animated: true)

        }
        //empty state
        else    {
            navigationController?.pushViewController(aCollection, animated: true)
        }
    }
}

extension AlbumsCollectionsController: AddCollectionGroupDelegate   {
    func addGroup(collection: AlbumCollection) {
        collections.append(collection)
    }
}

extension AlbumsCollectionsController: DataPersistenceDelegate  {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadCollections()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadCollections()
    }
     
}
