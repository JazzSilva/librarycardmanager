//
//  nextButton.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/29/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit


// This is a custom class of UITextField that is used on all patron registration views

protocol buttonDelegate: class {
    func onButtonTapped()
}

class nextButton: UIButton {
    weak var delegate: buttonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        formatButton()
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func formatButton() {
        self.backgroundColor = styleGuide.colors.greenAccent
        self.setTitleColor(styleGuide.colors.whitePrimary, for: .normal)
        self.setTitle("Next", for: .normal)
        self.titleLabel?.font = UIFont(name: "RobotoSlab-Bold", size: 22.0)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    @objc func buttonTapped() {
        self.delegate?.onButtonTapped()
    }
}

class selectionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        formatButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func formatButton() {
        self.backgroundColor = styleGuide.colors.navyPrimary
        self.setTitleColor(styleGuide.colors.whitePrimary, for: .normal)
        self.setTitle("Default", for: .normal)
        self.titleLabel?.font = UIFont(name: "RobotoSlab-Bold", size: 25.0)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 450).isActive = true
        self.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
