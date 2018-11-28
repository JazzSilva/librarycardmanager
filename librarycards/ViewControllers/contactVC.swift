//
//  contactVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class contactVC: UIViewController, buttonDelegate, SSRadioButtonControllerDelegate {
    
    var manager: libraryCardManager?
    var radioButtonController: SSRadioButtonsController?
    let phoneTextField = formTextField()
    let emailTextField = formTextField()
    let preferenceLabel = UILabel()
    let phoneButton = SSRadioButton()
    let emailButton = SSRadioButton()
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(phoneTextField)
        view.addSubview(emailTextField)
        view.addSubview(phoneButton)
        view.addSubview(emailButton)
        view.addSubview(doneButton)
        view.addSubview(preferenceLabel)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
        radioButtonController = SSRadioButtonsController(buttons: phoneButton, emailButton)
        manager?.printPatron()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        self.title = "Contact Information"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.pinkSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(cancelButton, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.aquaPrimary
        
        phoneTextField.formDelegate = self.manager
        phoneTextField.tag = 7
        phoneTextField.keyboardType = .phonePad
        if (self.manager?.activePatron?.phone != nil && self.manager?.activePatron?.phone != "") {
            phoneTextField.text = self.manager?.activePatron?.phone
        }
        else {
            phoneTextField.placeholder = "Phone"
        }
        phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        phoneTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        
        emailTextField.formDelegate = self.manager
        emailTextField.tag  = 8
        emailTextField.keyboardType = .emailAddress
        if (self.manager?.activePatron?.email != nil && self.manager?.activePatron?.email != "") {
            emailTextField.text = self.manager?.activePatron?.email
        }
        else {
            emailTextField.placeholder = "Email"
        }
        emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 50).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        preferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        preferenceLabel.text = "Contact Preference"
        preferenceLabel.font = UIFont(name: "RobotoSlab-Regular", size: 18)
        preferenceLabel.isUserInteractionEnabled = false
        preferenceLabel.adjustsFontSizeToFitWidth = true
        preferenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        preferenceLabel.bottomAnchor.constraint(equalTo: phoneButton.topAnchor, constant: -50).isActive = true
        preferenceLabel.textColor = styleGuide.colors.grayPrimary
        preferenceLabel.textAlignment = .right
        
        phoneButton.formatButton(title: "Phone")
        phoneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        phoneButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 150).isActive = true
        
        emailButton.formatButton(title: "Email")
        emailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailButton.topAnchor.constraint(equalTo: phoneButton.bottomAnchor, constant: 50).isActive = true
        
        if (self.manager?.activePatron?.contactPreference != nil && self.manager?.activePatron?.contactPreference != "Phone") {
            emailButton.isSelected = .init(true)
        }
        else {
            phoneButton.isSelected = .init(true)
        }
        
        radioButtonController = SSRadioButtonsController(buttons: phoneButton, emailButton)
        radioButtonController?.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
    }
    
    func onButtonTapped() {
        let nextViewController = securityVC()
        manager?.activePatron?.phone = phoneTextField.text
        manager?.activePatron?.email = emailTextField.text
        var currentButton = radioButtonController?.selectedButton()
        print(currentButton?.titleLabel?.text)
        if currentButton?.titleLabel != nil {
            manager?.activePatron?.contactPreference = currentButton?.titleLabel?.text
        }
        else {
            //Change this later to default contact preference from user defaults
            manager?.activePatron?.contactPreference = "PhoneDefault"
        }
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func didSelectButton(selectedButton: UIButton?)
    {
        print(" \(selectedButton)" )
    }
    
    @objc func cancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}


