//
//  contactVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class contactVC: UIViewController, buttonDelegate {
    
    let phoneTextField = formTextField()
    let emailTextField = formTextField()
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(phoneTextField)
        view.addSubview(emailTextField)
        view.addSubview(doneButton)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        phoneTextField.placeholder = "Phone Number"
        phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        phoneTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        
        emailTextField.placeholder = "Email Address"
        emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 100).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
    }
    
    func onButtonTapped() {
        let nextViewController = securityVC()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}


