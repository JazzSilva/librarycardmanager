//
//  LoginViewController.swift
//  librarycards
//
//  Created by Jasmin Silva on 11/1/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(submitButton)
        title = "Library Card Manager"
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor.white
        formatTextField(field: passwordTextField)
        formatTextField(field: usernameTextField)
        
        usernameTextField.placeholder = "Username"
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 100).isActive = true
        
        submitButton.backgroundColor = styleGuide.colors.grayPrimary
        submitButton.setTitleColor(styleGuide.colors.whitePrimary, for: .normal)
        submitButton.setTitle("Sign In", for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "RobotoSlab-Bold", size: 20.0)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        submitButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 150).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        submitButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    func formatTextField(field: UITextField) {
        field.borderStyle = .roundedRect
        field.backgroundColor = .white
        field.textColor = .black
        field.font = UIFont(name: "RobotoSlab-Regular", size: 18.0)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.widthAnchor.constraint(equalToConstant: 500).isActive = true
        field.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc private func login() {
        // store the user session (example only, not for the production)
        //UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        // navigate to the Main Screen
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil{
                AppDelegate.shared.rootViewController.switchToMainScreen()
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
