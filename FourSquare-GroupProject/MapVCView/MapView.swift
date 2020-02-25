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
    
    public lazy var searchTheArea: UITextField = {
       let areaTextField = UITextField()
        areaTextField.autocapitalizationType = .none
        areaTextField.placeholder = "tell us the AREA you are interested in"
        areaTextField.backgroundColor = .white
        areaTextField.borderStyle = .roundedRect
        return areaTextField
    }()
    
    public lazy var searchTheKindOfFood: UITextField = {
          let foodTextField = UITextField()
        foodTextField.autocapitalizationType = .none
        foodTextField.placeholder = "tell us the FOOD you are interested in"
        foodTextField.backgroundColor = .white
        foodTextField.borderStyle = .roundedRect
           return foodTextField
       }()
    
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
        setUpAreaSearchBar()
        setUpFoodSearchBar()
    }
    
    private func setupAvenueMapView()   {
        addSubview(avenueMapView)
        
        avenueMapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            avenueMapView.topAnchor.constraint(equalTo: topAnchor),
            avenueMapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avenueMapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            avenueMapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
    
    private func setUpAreaSearchBar() {
        addSubview(searchTheArea)
               
               searchTheArea.translatesAutoresizingMaskIntoConstraints = false
               
               NSLayoutConstraint.activate([
                searchTheArea.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                   searchTheArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
                   searchTheArea.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
                   searchTheArea.heightAnchor.constraint(equalToConstant: 40)
                //   searchTheArea.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
               ])
        
    }
    
    private func setUpFoodSearchBar() {
        addSubview(searchTheKindOfFood)
                      
                      searchTheKindOfFood.translatesAutoresizingMaskIntoConstraints = false
                      
                      NSLayoutConstraint.activate([
                      
                        searchTheKindOfFood.topAnchor.constraint(equalTo: searchTheArea.bottomAnchor),
                          searchTheKindOfFood.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
                          searchTheKindOfFood.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
                          searchTheArea.heightAnchor.constraint(equalToConstant: 25)
                      
                      ])
    }
}
