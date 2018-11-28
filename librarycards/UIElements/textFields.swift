//
//  textFields.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/29/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

protocol formUpdateDelegate: class {
    func fieldDidBecomeActive(_ textField: UITextField)
}

// This is a custom class of UITextField that is used on all patron registration views

class formTextField: UITextField {
    
    weak var formDelegate: formUpdateDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        formatTextField()
        self.addTarget(self, action: #selector(shouldReturn(_:)), for: .editingDidEndOnExit)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func formatTextField() {
        self.borderStyle = .roundedRect
        self.backgroundColor = styleGuide.colors.whitePrimary
        self.textColor = styleGuide.colors.grayPrimary
        self.font = UIFont(name: "RobotoSlab-Regular", size: 18.0)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 500).isActive = true
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.autocapitalizationType = .sentences
        self.autocorrectionType = .no
        self.returnKeyType = .next
        self.clearButtonMode = .unlessEditing
        self.keyboardType = .default
        self.enablesReturnKeyAutomatically = true
    }
    
    @objc func shouldReturn(_ textField: UITextField) {
        self.formDelegate?.fieldDidBecomeActive(textField)
    }
    
}

extension libraryCardManager {
    
    func fieldDidBecomeActive(_ textField: UITextField) {
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder?
        
        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
    }
}
