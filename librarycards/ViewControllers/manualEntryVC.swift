//
//  manualEntryVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class manualEntry: UIViewController, buttonDelegate {
    
    let firstNameTextField = formTextField()
    let lastNameTextField = formTextField()
    let address1TextField = formTextField()
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(address1TextField)
        view.addSubview(doneButton)
        doneButton.delegate = self
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 100).isActive = true
        lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        address1TextField.placeholder = "Address"
        address1TextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 100).isActive = true
        address1TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    func onButtonTapped() {
        let nextViewController = Contact()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}