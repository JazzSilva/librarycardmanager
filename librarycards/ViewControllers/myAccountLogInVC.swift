//
//  myAccountLogInVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class myAccountLoginVC: UIViewController {
    
    let loginButton = selectionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        loginButton.setTitle("Login to My Account", for: .normal)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    
    }
    
    @objc func loginTapped() {
        let nextViewController = myAccountVC()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
