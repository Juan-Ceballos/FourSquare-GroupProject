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
    
    private let dataPersistence: DataPersistence<AlbumCollection>
    //private var secondDataPer = DataPersistence<AlbumCollection>(filename: "collections.plist")

    init(_ dataPersistence:DataPersistence<AlbumCollection>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coser:) has  not been implemented")
    }

    let collectionView = CollectionView()
    
    var collections = [AlbumCollection](){
        didSet{
            collectionView.collections.reloadData()
          if collections.isEmpty {
            collectionView.collections.backgroundView = EmptyView(title: "Empty", message: "Please add to fill")
          } else {
            collectionView.collections.reloadData()
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
        collectionView.collections.register(CollectionCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.collections.dataSource = self
        collectionView.collections.delegate = self
        dataPersistence.delegate = self
        //secondDataPer.delegate = self
        configureNavBar()
        loadCollections()
    }
    
    private func loadCollections() {
        do {
            //collections = try secondDataPer.loadItems()
            collections = try dataPersistence.loadItems()
        } catch {
            print(error)
        }
    }
    
    private func configureNavBar()  {
        self.navigationItem.title = "My Collection"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pressButton))
    }
    
    @objc private func pressButton()  {
        let addCollectionController = AddCollectionController(dataPersistence, venue: nil)
        navigationController?.pushViewController(addCollectionController, animated: true)
        addCollectionController.delegate = self
    }
    
}

extension AlbumsCollectionsController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionCell
            else    {
                fatalError()
        }
        
        cell.configureCellEmpty(for: collections[indexPath.row])
        cell.backgroundColor = .green
        cell.delegate = self
        return cell
    }
    
}

extension AlbumsCollectionsController: UICollectionViewDelegateFlowLayout   {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = CGSize(width: 200, height: 200)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("pressed")
        
        let collectionVenues = collections[indexPath.row].arrVenues
        
        //let aCollection = ACollectionController(secondDataPer, venue: collectionVenues)
        
        let aCollection = ACollectionController(dataPersistence, venue: collectionVenues)
        
        if collectionVenues.isEmpty  {
            print("Empty")
          navigationController?.pushViewController(aCollection, animated: true)
        }
        else    {
            navigationController?.pushViewController(aCollection, animated: true)
        }
    }
    
}

extension AlbumsCollectionsController: AddCollectionGroupDelegate   {
    func addGroup(group: AlbumCollection) {
        collections.append(group)
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

extension AlbumsCollectionsController: CollectionCellDelegate   {
    func didLongPress(_ collectionCell: CollectionCell) {
        print("cell was selected")
        
        guard let indexPath = collectionView.collections.indexPath(for: collectionCell)
            else    {
                return
        }
        
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive)  { [weak self] alertAction in
            self?.deleteGroup(indexPath: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func deleteGroup(indexPath: IndexPath)  {
        do  {
            try dataPersistence.deleteItem(at: indexPath.row)
        }
        catch   {
            print("error")
        }
    }
    
}
