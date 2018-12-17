//
//  manualEntryVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class manualEntryVC: UIViewController, buttonDelegate, UITextFieldDelegate {
    

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
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [styleGuide.colors.aquaPrimary?.cgColor, styleGuide.colors.navyPrimary?.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        setGradient()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        //setGradient()
        
        self.title = "Patron Information"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(cancelButton, animated: true)
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.whiteSecondary
        
        firstNameTextField.formDelegate = self.manager
        firstNameTextField.tag = 4
        if (self.manager?.activePatron?.firstName != nil && self.manager?.activePatron?.firstName != "") {
            firstNameTextField.text = self.manager?.activePatron?.firstName
        }
        else {
            firstNameTextField.placeholder = "First Name"
        }
        firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -260).isActive = true
        
        middleNameTextField.formDelegate = self.manager
        middleNameTextField.tag = 5
        if (self.manager?.activePatron?.middleName != nil && self.manager?.activePatron?.middleName != "") {
            middleNameTextField.text = self.manager?.activePatron?.middleName
        }
        else {
            middleNameTextField.placeholder = "Middle Name"
        }
        middleNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 15).isActive = true
        middleNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        lastNameTextField.formDelegate = self.manager
        lastNameTextField.tag = 6
        if (self.manager?.activePatron?.lastName != nil && self.manager?.activePatron?.lastName != "") {
            lastNameTextField.text = self.manager?.activePatron?.lastName
        }
        else {
            lastNameTextField.placeholder = "Last Name"
        }
        lastNameTextField.topAnchor.constraint(equalTo: middleNameTextField.bottomAnchor, constant: 15).isActive = true
        lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        address1TextField.delegate = self
        formatTextField(address1TextField)
        if (self.manager?.activePatron?.address != nil && self.manager?.activePatron?.address != "") {
            address1TextField.text = self.manager?.activePatron?.address
        }
        else {
            address1TextField.placeholder = "Mailing Address"
        }
        address1TextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 15).isActive = true
        address1TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
        
    }
    
    func onButtonTapped() {
        if (firstNameTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Sorry!", message: "Please complete all fields.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let nextViewController = contactVC()
            manager?.activePatron?.firstName = firstNameTextField.text
            manager?.activePatron?.middleName = middleNameTextField.text
            manager?.activePatron?.lastName = lastNameTextField.text
            manager?.activePatron?.address = address1TextField.text
            nextViewController.manager = self.manager
            navigationController?.pushViewController(nextViewController, animated: true)
        }
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

