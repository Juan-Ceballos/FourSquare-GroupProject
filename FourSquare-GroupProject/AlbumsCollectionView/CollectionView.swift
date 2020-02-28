//
//  CollectionView.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class CollectionView: UIView  {
    
    public lazy var collections: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .blue
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit()   {
        setupCollectionsConstraints()
    }
    
    private func setupCollectionsConstraints() {
        addSubview(collections)
        collections.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            collections.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collections.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collections.trailingAnchor.constraint(equalTo: trailingAnchor),
            collections.leadingAnchor.constraint(equalTo: leadingAnchor)
        
        ])
    }
}
