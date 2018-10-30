//
//  parentLogInVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class parentLogInVC: UIViewController {
    
    let signInParentButton = selectionButton()
    let parentRegistrationButton = selectionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signInParentButton)
        view.addSubview(parentRegistrationButton)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        signInParentButton.setTitle("Sign in as Parent", for: .normal)
        signInParentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInParentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        signInParentButton.addTarget(self, action: #selector(signInParentTapped), for: .touchUpInside)
        
        parentRegistrationButton.setTitle("I'll first need a library card.", for: .normal)
        parentRegistrationButton.topAnchor.constraint(equalTo: signInParentButton.bottomAnchor, constant: 100).isActive = true
        parentRegistrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        parentRegistrationButton.addTarget(self, action: #selector(parentRegistrationTapped), for: .touchUpInside)
        
    }
    
    @objc func signInParentTapped() {
        let nextViewController = addKidsVC()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func parentRegistrationTapped() {
        let nextViewController = swipeVC()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
