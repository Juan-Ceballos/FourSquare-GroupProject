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
    
    private let dp: DataPersistence<Venue>
    init(_ dataPersistence:DataPersistence<Venue>) {
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
        configureNavBar()
        
        
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
}

extension AlbumsCollectionsController: AddCollectionGroupDelegate   {
    func addGroup(collection: AlbumCollection) {
        collections.append(collection)
    }

}
