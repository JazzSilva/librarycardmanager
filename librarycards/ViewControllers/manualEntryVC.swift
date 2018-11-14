//
//  manualEntryVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class manualEntryVC: UIViewController, buttonDelegate {
    
    func didUpdateData(data: String) {
        print("data is", data)
    }
    
    var manager: libraryCardManager?
    let firstNameTextField = formTextField()
    let middleNameTextField = formTextField()
    let lastNameTextField = formTextField()
    let address1TextField = formTextField()
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(firstNameTextField)
        view.addSubview(middleNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(address1TextField)
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
        
        firstNameTextField.formDelegate = self.manager
        if (self.manager?.activePatron?.firstName != nil && self.manager?.activePatron?.firstName != "") {
            firstNameTextField.text = self.manager?.activePatron?.firstName
        }
        else {
            firstNameTextField.placeholder = "First Name"
        }
        firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        
        middleNameTextField.formDelegate = self.manager
        if (self.manager?.activePatron?.middleName != nil && self.manager?.activePatron?.middleName != "") {
            middleNameTextField.text = self.manager?.activePatron?.middleName
        }
        else {
            middleNameTextField.placeholder = "Middle Name"
        }
        middleNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 50).isActive = true
        middleNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        lastNameTextField.formDelegate = self.manager
        if (self.manager?.activePatron?.lastName != nil && self.manager?.activePatron?.lastName != "") {
            lastNameTextField.text = self.manager?.activePatron?.lastName
        }
        else {
            lastNameTextField.placeholder = "Last Name"
        }
        lastNameTextField.topAnchor.constraint(equalTo: middleNameTextField.bottomAnchor, constant: 50).isActive = true
        lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        address1TextField.formDelegate = self.manager
        if (self.manager?.activePatron?.address != nil && self.manager?.activePatron?.address != "") {
            address1TextField.text = self.manager?.activePatron?.address
        }
        else {
            address1TextField.placeholder = "Address"
        }
        address1TextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 50).isActive = true
        address1TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
    }
    
    func onButtonTapped() {
        let nextViewController = contactVC()
        manager?.activePatron?.firstName = firstNameTextField.text
        manager?.activePatron?.middleName = middleNameTextField.text
        manager?.activePatron?.lastName = lastNameTextField.text
        manager?.activePatron?.address = address1TextField.text
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

