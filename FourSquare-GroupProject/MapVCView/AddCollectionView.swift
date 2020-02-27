//
//  AddCollectionView.swift
//  FourSquare-GroupProject
//
//  Created by Juan Ceballos on 2/21/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class AddCollectionView: UIView {
    
    public lazy var namingTextField: UITextField  =  {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Add or Create Collection"
        textField.textAlignment = .center
        return textField
    }()
    
    override init(frame: CGRect)    {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
 
    required init?(coder: NSCoder)   {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit()   {
        setupNamingTextFieldConstraints()
    }
    
    private func setupNamingTextFieldConstraints()  {
        addSubview(namingTextField)
        
        namingTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            namingTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            namingTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            namingTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        ])
    }
}
