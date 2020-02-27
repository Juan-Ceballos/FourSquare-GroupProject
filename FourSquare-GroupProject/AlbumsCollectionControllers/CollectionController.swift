//
//  CollectionControllers.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class CollectionController: UIViewController {

    let collectionView = CollectionView()
    var collections = [String]()
    
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
        let addCollectionController = AddCollectionController()
        navigationController?.pushViewController(addCollectionController, animated: true)
    }
    
}

extension CollectionController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
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

extension CollectionController: UICollectionViewDelegateFlowLayout    {
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
