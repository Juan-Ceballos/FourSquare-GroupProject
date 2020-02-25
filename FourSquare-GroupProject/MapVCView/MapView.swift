//
//  MapView.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {
    
    public lazy var avenueMapView: MKMapView =    {
       let mapView = MKMapView()
        return mapView
    }()
  

    
    public lazy var foodCollectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
      layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemIndigo
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
    
    func commonInit()   {
       setupAvenueMapView()
      collectionViewConstraints()
    }
    
    private func setupAvenueMapView()   {
        addSubview(avenueMapView)
        
        avenueMapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            avenueMapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            avenueMapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avenueMapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            avenueMapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
  
  private func collectionViewConstraints() {
  addSubview(foodCollectionView)
    foodCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      foodCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 10),
      foodCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      foodCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      foodCollectionView.heightAnchor.constraint(equalToConstant: 100)
    ])
  }
    
}
