//
//  SaveVenueView.swift
//  FourSquare-GroupProject
//
//  Created by Liubov Kaper  on 2/28/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

protocol ANewCollectionDelegate {
    func segueToAddNewCollectionController()
    //func checkTheMadeCollections()
}

class SaveVenueView: UIView {
     var delegate: ANewCollectionDelegate?
    
    private var aAlbumCollection: AlbumCollection?
    
     public lazy var blueButton: UIButton = {
           // https://stackoverflow.com/questions/26050655/how-to-create-a-circular-button-in-swift
            let blueButton = UIButton(type: .custom)
            //blueButton.sizeToFit()
            blueButton.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
            blueButton.layer.cornerRadius = blueButton.frame.size.width / 3
           // blueButton.layer.cornerRadius = blueButton.frame.size.height / 2
            blueButton.clipsToBounds = true
            blueButton.backgroundColor = .blue
    //blueButton.frame(forAlignmentRect: CGRect()
           // https://freakycoder.com/ios-notes-11-how-to-create-a-circle-button-with-shadow-9a9c902a3a56
            // below makes the shadow for the button
            blueButton.layer.shadowColor = UIColor.black.cgColor
                blueButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                blueButton.layer.masksToBounds = false
                blueButton.layer.shadowRadius = 1.0
                blueButton.layer.shadowOpacity = 0.5
                blueButton.layer.cornerRadius = blueButton.frame.width / 2
        
        
        blueButton.addTarget(self, action: #selector(goSomeWhere), for: .touchUpInside)
        
        blueButton.titleLabel?.text = "Make a new collection"
        blueButton.titleLabel?.textColor = .black
            return blueButton
        }()
    
    @objc func goSomeWhere() {
        print("the button was touched")
                delegate?.segueToAddNewCollectionController()

    }
    
   // @objc func
    
    
    public lazy var greenButton: UIButton = {
              let greenButton = UIButton(type: .custom)
                //blueButton.sizeToFit()
                greenButton.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
                greenButton.layer.cornerRadius = greenButton.frame.size.width / 3
               // blueButton.layer.cornerRadius = blueButton.frame.size.height / 2
                greenButton.clipsToBounds = true
                greenButton.backgroundColor = .blue
        //blueButton.frame(forAlignmentRect: CGRect()
               // https://freakycoder.com/ios-notes-11-how-to-create-a-circle-button-with-shadow-9a9c902a3a56
                // below makes the shadow for the button
                greenButton.layer.shadowColor = UIColor.black.cgColor
                    greenButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                    greenButton.layer.masksToBounds = false
                    greenButton.layer.shadowRadius = 1.0
                    greenButton.layer.shadowOpacity = 0.5
                    greenButton.layer.cornerRadius = greenButton.frame.width / 2
        greenButton.titleLabel?.text = "Here are the older collections"
        greenButton.titleLabel?.textColor = .black
        greenButton.backgroundColor = .green
        return greenButton
        
    }()
    
     public lazy var viewHazyLayer: UIView = {
           let iv = UIView()
          iv.backgroundColor = .black
          iv.alpha = 0.3
                   
            return iv
        }()
    
    
      public lazy var stackView: UIStackView = {
            let stackView = UIStackView()
    //https://stackoverflow.com/questions/58162441/adding-buttons-programmatically-to-stackview-in-swift
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 25.0
            stackView.backgroundColor = .white
            return stackView
        }()
    

    override init(frame: CGRect) {
        super.init(frame:UIScreen.main.bounds)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commomInit()
    }
    
    private func commomInit() {
        setUpviewHazyLayerConstraints()
        setUpStackView()
    }

    
    private func setUpviewHazyLayerConstraints(){
        addSubview(viewHazyLayer)
        
        viewHazyLayer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        // want some padding
            // with cell constraints there is no need for safe area constraints
            viewHazyLayer.topAnchor.constraint(equalTo: topAnchor)
            // top is postive because we are going down
            // want some padding because it shouldn't be touching it.. should have some distance
            ,
            viewHazyLayer.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewHazyLayer.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewHazyLayer.bottomAnchor.constraint(equalTo: bottomAnchor)
           // imageView.heightAnchor.constraint(equalTo: heightAnchor),
           // imageView.widthAnchor.constraint(equalTo: newsImageView.heightAnchor)
        ])
    }
    
    private func setUpStackView() {
        
        addSubview(stackView)
        
        // this is adding this into the box.
        stackView.addArrangedSubview(blueButton)
        stackView.addArrangedSubview(greenButton)
                
        //arranges it inside of the stack box..
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
           // stackView.heightAnchor.constraint(equalToConstant: 300),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -300)
        
        ])
    }
    
    
}
