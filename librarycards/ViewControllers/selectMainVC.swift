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
    
    var manager: libraryCardManager?
    let signUpButton = selectionButton()
    let myAccountButton = selectionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signUpButton)
        view.addSubview(myAccountButton)
        UserDefaults.standard.register(defaults: [String : Any]())
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        manager = libraryCardManager()
        manager?.printPatron()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        //Pull the branch name from user settings to display
        let userDefaults = UserDefaults.standard
        let branchName = userDefaults.string(forKey: "branch_name") ?? "HCPL"
        title = "Welcome to \(branchName)!"
        
        let logoutButton = UIBarButtonItem(title: "Staff", style: .plain, target: self, action: #selector(logout))
        navigationItem.setLeftBarButton(logoutButton, animated: true)
        
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
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func myAccountTapped() {
        let nextViewController = myAccountLoginVC()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc
    private func logout() {
        // clear the user session (example only, not for the production)
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        AppDelegate.shared.rootViewController.switchToLogout()
        // navigate to the Main Screen
    }

}
