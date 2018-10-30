//
//  selectMainVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class selectMainVC: UIViewController {
    
    let signUpButton = selectionButton()
    let myAccountButton = selectionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signUpButton)
        view.addSubview(myAccountButton)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        signUpButton.setTitle("Sign-Up", for: .normal)
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        myAccountButton.setTitle("My Account", for: .normal)
        myAccountButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 100).isActive = true
        myAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myAccountButton.addTarget(self, action: #selector(myAccountTapped), for: .touchUpInside)
    }
    
    @objc func signUpTapped() {
        let nextViewController = selectRegistrantVC()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func myAccountTapped() {
        let nextViewController = myAccountLoginVC()
        navigationController?.pushViewController(nextViewController, animated: true)
    }

}
