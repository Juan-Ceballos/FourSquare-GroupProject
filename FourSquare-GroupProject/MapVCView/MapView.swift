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
    
    private lazy var panGesture: UIGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didPanGesture(_:)))
        return gesture
    }()
    
    public lazy var resultsButton: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage(systemName: "line.horizontal.3")
        button.tintColor = .black
        button.backgroundColor = .black
        return button
    }()
    
    
    
    public lazy var searchTheArea: UITextField = {
        let areaTextField = UITextField()
        areaTextField.autocapitalizationType = .none
        areaTextField.placeholder = "tell us the AREA you are interested in"
        areaTextField.backgroundColor = .white
        areaTextField.borderStyle = .roundedRect
        areaTextField.clearButtonMode = .whileEditing
        return areaTextField
    }()
    
    public lazy var searchTheKindOfFood: UITextField = {
        let foodTextField = UITextField()
        foodTextField.autocapitalizationType = .none
        foodTextField.placeholder = "tell us the FOOD you are interested in"
        foodTextField.backgroundColor = .white
        foodTextField.borderStyle = .roundedRect
        foodTextField.clearButtonMode = .whileEditing
        return foodTextField
    }()
    
    public lazy var actualMapView: MKMapView =    {
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
        setUpFoodSearchBar()
        setUpAreaSearchBar()
        setUpCollectionView()
        configureButtonSetup()
        // registers what is being done... because the interacton of the gesture should be recognized when the map is moved so it can populate properly.
        actualMapView.isUserInteractionEnabled = true
        addGestureRecognizer(panGesture)
    }
    
    @objc func didPanGesture(_ gesture: UILongPressGestureRecognizer) {
        print("pan gesture is RECOGNIZED")
        
        // want the annotations to appear based on whatever region it displayed
        if gesture.state == .began || gesture.state == .changed {
            print("we panning bitch")
            return
        }
        reloadTheAnnotations()
    }
    
    private func reloadTheAnnotations() {
        let controller = MapController()
        
        // inside of loadMap the annotation func that has a return value gets called and used.
        controller.loadMap()
    }
    
    private func setUpFoodSearchBar() {
           addSubview(searchTheKindOfFood)
           searchTheKindOfFood.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               searchTheKindOfFood.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
               searchTheKindOfFood.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
               searchTheKindOfFood.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
               //  searchTheArea.heightAnchor.constraint(equalToConstant: 40)
               //   searchTheArea.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
           ])
       }
       
    
    private func configureButtonSetup(){
        addSubview(resultsButton)
        
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            resultsButton.leadingAnchor.constraint(equalTo: searchTheKindOfFood.trailingAnchor),
            resultsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant:  -10),
            resultsButton.heightAnchor.constraint(equalToConstant: 20)
    
        ])
    }
    
    private func setUpCollectionView() {
        addSubview(foodCollectionView)
        
        foodCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            foodCollectionView.topAnchor.constraint(equalTo: searchTheArea.bottomAnchor, constant: 550),
            foodCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            foodCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            foodCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
    
    private func setupAvenueMapView()   {
        addSubview(actualMapView)
        
        actualMapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            actualMapView.topAnchor.constraint(equalTo: topAnchor),
            actualMapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            actualMapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            actualMapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    private func setUpAreaSearchBar() {
        addSubview(searchTheArea)
        searchTheArea.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            searchTheArea.topAnchor.constraint(equalTo: searchTheKindOfFood.bottomAnchor, constant: 10),
            searchTheArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            searchTheArea.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            // searchTheArea.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }
    
   
    
}

