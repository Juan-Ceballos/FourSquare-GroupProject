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
    
}
