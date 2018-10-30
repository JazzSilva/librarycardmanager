//
//  selectMainVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class selectMain: UIViewController {
    
    let signUpButton = UIButton()
    let myAccountButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        signUpButton.backgroundColor = .black
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.setTitle("Sign-Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "RobotoSlab-Bold", size: 25.0)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        myAccountButton.backgroundColor = .black
        myAccountButton.setTitleColor(.white, for: .normal)
        myAccountButton.setTitle("My Account", for: .normal)
        myAccountButton.titleLabel?.font = UIFont(name: "RobotoSlab-Bold", size: 25.0)
        myAccountButton.translatesAutoresizingMaskIntoConstraints = false
        myAccountButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myAccountButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        myAccountButton.addTarget(self, action: #selector(myAccountTapped), for: .touchUpInside)
        view.addSubview(myAccountButton)
        
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        
        myAccountButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 100).isActive = true
        myAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func signUpTapped() {
        let nextViewController = selectRegistrant()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func myAccountTapped() {
        let nextViewController = myAccountLogIn()
        navigationController?.pushViewController(nextViewController, animated: true)
    }

}
