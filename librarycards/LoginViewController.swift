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

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(submitButton)
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor.white
        formatTextField(field: passwordTextField)
        formatTextField(field: usernameTextField)
        
        title = "Library Card Services"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: styleGuide.colors.grayPrimary,
             NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Bold", size: 36)!]
        
        usernameTextField.placeholder = "Email"
        usernameTextField.delegate = self
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        usernameTextField.returnKeyType = .next
        usernameTextField.clearButtonMode = .unlessEditing
        usernameTextField.keyboardType = .emailAddress
        usernameTextField.enablesReturnKeyAutomatically = true
        usernameTextField.tag = 1
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        
        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.returnKeyType = .next
        passwordTextField.clearButtonMode = .unlessEditing
        passwordTextField.keyboardType = .namePhonePad
        passwordTextField.enablesReturnKeyAutomatically = true
        passwordTextField.tag = 2
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 50).isActive = true
        
        submitButton.backgroundColor = styleGuide.colors.grayPrimary
        submitButton.setTitleColor(styleGuide.colors.whitePrimary, for: .normal)
        submitButton.setTitle("Sign In", for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "RobotoSlab-Bold", size: 22.0)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        submitButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 150).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        submitButton.layer.shadowColor = styleGuide.colors.grayPrimary?.cgColor
        submitButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        submitButton.layer.shadowOpacity = 1.0
        submitButton.layer.shadowRadius = 2.6
        submitButton.layer.masksToBounds = false
        submitButton.layer.cornerRadius = 4.0
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder?
        
        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        return false
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
