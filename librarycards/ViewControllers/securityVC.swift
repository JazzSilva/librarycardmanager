//
//  securityVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class securityVC: UIViewController, buttonDelegate {
    
    var manager: libraryCardManager?
    let pinTextField = formTextField()
    let codeWordTextField = formTextField()
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pinTextField)
        view.addSubview(codeWordTextField)
        view.addSubview(doneButton)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager?.printPatron()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.setRightBarButton(cancelButton, animated: true)
        
        pinTextField.formDelegate = self.manager
        pinTextField.isSecureTextEntry = true
        if (self.manager?.activePatron?.pin != nil && self.manager?.activePatron?.pin != "") {
            pinTextField.text = self.manager?.activePatron?.pin
        }
        else {
            pinTextField.placeholder = "Pin"
        }
        pinTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pinTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        
        codeWordTextField.formDelegate = self.manager
        if (self.manager?.activePatron?.codeWord != nil && self.manager?.activePatron?.codeWord != "") {
            codeWordTextField.text = self.manager?.activePatron?.codeWord
        }
        else {
            codeWordTextField.placeholder = "Mother's Maiden Name"
        }
        codeWordTextField.topAnchor.constraint(equalTo: pinTextField.bottomAnchor, constant: 100).isActive = true
        codeWordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
    }
    
    func onButtonTapped() {
        let nextViewController = responseVC()
        nextViewController.manager = self.manager
        manager?.activePatron?.pin = pinTextField.text
        manager?.activePatron?.codeWord = codeWordTextField.text
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func cancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
