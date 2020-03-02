//
//  CollectionCell.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 3/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate: AnyObject {
    func didLongPress(_ collectionCell: CollectionCell)
}

class CollectionCell: UICollectionViewCell  {
    
    // collection cell: Image, Given title
    // image is default, until venue added
    
    public weak var delegate: CollectionCellDelegate?
    
    private lazy var longPressGesture: UILongPressGestureRecognizer  =   {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        return gesture
    }()
    
    private lazy var collectionImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.fill")
        return image
    }()
    
    private lazy var collectionTitle: UILabel = {
        let label = UILabel()
        label.text = "default"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit()   {
        setupCollectionImageConstraints()
        setupCollectionLabelConstraints()
        addGestureRecognizer(longPressGesture)
    }
    
    public func configureCellEmpty(for newCollection: AlbumCollection) {
        collectionTitle.text = newCollection.title
    }
    
    @objc private func longPressAction(gesture: UILongPressGestureRecognizer)   {
        if gesture.state == .began  {
            gesture.state = .cancelled
            return
        }
        
        delegate?.didLongPress(self)
    }
    
    private func setupCollectionImageConstraints()  {
        
        addSubview(collectionImage)
        
        collectionImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionImage.topAnchor.constraint(equalTo: topAnchor),
            collectionImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        ])
    }
    
    private func setupCollectionLabelConstraints()  {
        
        addSubview(collectionTitle)
        
        collectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            collectionTitle.topAnchor.constraint(equalTo: collectionImage.bottomAnchor),
            collectionTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
    
}
