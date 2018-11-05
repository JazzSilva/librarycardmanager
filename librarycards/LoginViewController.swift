//
//  LoginViewController.swift
//  librarycards
//
//  Created by Jasmin Silva on 11/1/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Login Screen"
        
        let loginButton = UIBarButtonItem(title: "Log In", style: .plain, target: self, action: #selector(login))
        navigationItem.setLeftBarButton(loginButton, animated: true)
    }
    
    @objc private func login() {
        // store the user session (example only, not for the production)
        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        // navigate to the Main Screen
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
}
