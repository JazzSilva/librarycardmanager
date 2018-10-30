//
//  textFields.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/29/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit


// This is a custom class of UITextField that is used on all patron registration views

class formTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        formatTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func formatTextField() {
        self.borderStyle = .roundedRect
        self.backgroundColor = .white
        self.textColor = .black
        self.font = UIFont(name: "RobotoSlab-Regular", size: 18.0)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 500).isActive = true
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}