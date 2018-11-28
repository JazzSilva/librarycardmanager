//
//  parentLogInVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class parentLogInVC: UIViewController, buttonDelegate, UITextFieldDelegate {
    
    func didUpdateData(data: String) {
        print("data is", data)
    }
    
    var manager: libraryCardManager?
    let firstNameTextField = formTextField()
    let middleNameTextField = formTextField()
    let lastNameTextField = formTextField()
    let address1TextField = UITextField()
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
        
        self.title = "Parent/Guardian Information"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.pinkSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(cancelButton, animated: true)
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.aquaPrimary
        
        firstNameTextField.formDelegate = self.manager
        firstNameTextField.tag = 4
        if (self.manager?.activePatron?.firstName != nil && self.manager?.activePatron?.firstName != "") {
            firstNameTextField.text = self.manager?.activePatron?.firstName
        }
        else {
            firstNameTextField.placeholder = "Parent's First Name"
        }
        firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -220).isActive = true
        
        middleNameTextField.formDelegate = self.manager
        middleNameTextField.tag = 5
        if (self.manager?.activePatron?.middleName != nil && self.manager?.activePatron?.middleName != "") {
            middleNameTextField.text = self.manager?.activePatron?.middleName
        }
        else {
            middleNameTextField.placeholder = "Parent's Middle Name"
        }
        middleNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 30).isActive = true
        middleNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        lastNameTextField.formDelegate = self.manager
        lastNameTextField.tag = 6
        if (self.manager?.activePatron?.lastName != nil && self.manager?.activePatron?.lastName != "") {
            lastNameTextField.text = self.manager?.activePatron?.lastName
        }
        else {
            lastNameTextField.placeholder = "Parent's Last Name"
        }
        lastNameTextField.topAnchor.constraint(equalTo: middleNameTextField.bottomAnchor, constant: 30).isActive = true
        lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        address1TextField.delegate = self
        formatTextField(address1TextField)
        if (self.manager?.activePatron?.address != nil && self.manager?.activePatron?.address != "") {
            address1TextField.text = self.manager?.activePatron?.address
        }
        else {
            address1TextField.placeholder = "Parent's Mailing Address"
        }
        address1TextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 50).isActive = true
        address1TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        doneButton.titleLabel?.text = "Add Children"
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
    }
    
    func onButtonTapped() {
        let nextViewController = addKidsVC()
        manager?.activePatron?.firstName = firstNameTextField.text
        manager?.activePatron?.middleName = middleNameTextField.text
        manager?.activePatron?.lastName = lastNameTextField.text
        manager?.activePatron?.address = address1TextField.text
        manager?.addChild()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func cancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func formatTextField(_ textField: UITextField) {
        textField.borderStyle = .roundedRect
        textField.backgroundColor = styleGuide.colors.whitePrimary
        textField.textColor = styleGuide.colors.grayPrimary
        textField.font = UIFont(name: "RobotoSlab-Regular", size: 18.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 500).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.clearButtonMode = .unlessEditing
        textField.keyboardType = .default
        textField.enablesReturnKeyAutomatically = true
    }
    
}
