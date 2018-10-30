//
//  selectRegistrantVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class selectRegistrant: UIViewController {
    
    let registeringMyselfButton = UIButton()
    let registeringChildButton = UIButton()
    
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
        
        registeringMyselfButton.backgroundColor = .black
        registeringMyselfButton.setTitleColor(.white, for: .normal)
        registeringMyselfButton.setTitle("Registering for Myself", for: .normal)
        registeringMyselfButton.titleLabel?.font = UIFont(name: "RobotoSlab-Bold", size: 25.0)
        registeringMyselfButton.translatesAutoresizingMaskIntoConstraints = false
        registeringMyselfButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        registeringMyselfButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        registeringMyselfButton.addTarget(self, action: #selector(registeringMyselfTapped), for: .touchUpInside)
        view.addSubview(registeringMyselfButton)
        
        registeringChildButton.backgroundColor = .black
        registeringChildButton.setTitleColor(.white, for: .normal)
        registeringChildButton.setTitle("Registering for My Child", for: .normal)
        registeringChildButton.titleLabel?.font = UIFont(name: "RobotoSlab-Bold", size: 25.0)
        registeringChildButton.translatesAutoresizingMaskIntoConstraints = false
        registeringChildButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        registeringChildButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        registeringChildButton.addTarget(self, action: #selector(registeringChildTapped), for: .touchUpInside)
        view.addSubview(registeringChildButton)
        
        registeringMyselfButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registeringMyselfButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        
        registeringChildButton.topAnchor.constraint(equalTo: registeringMyselfButton.bottomAnchor, constant: 100).isActive = true
        registeringChildButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func registeringMyselfTapped() {
        let nextViewController = Swipe()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func registeringChildTapped() {
        let nextViewController = parentLogIn()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
