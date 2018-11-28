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
    let registeringMyselfButton = selectionButton()
    let registeringChildButton = selectionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(registeringMyselfButton)
        view.addSubview(registeringChildButton)
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
        
        let userDefaults = UserDefaults.standard
        let branchName = userDefaults.string(forKey: "branch_name") ?? "Harris County Public Library"
        
        let logoutButton = UIBarButtonItem(title: "Log-Out", style: .plain, target: self, action: #selector(logout))
        logoutButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.pinkSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(logoutButton, animated: true)
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.aquaPrimary
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: styleGuide.colors.grayPrimary,
             NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Bold", size: 36)!]
        
        self.title = branchName
        
        registeringMyselfButton.setTitle("Registering for Myself", for: .normal)
        registeringMyselfButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registeringMyselfButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        registeringMyselfButton.addTarget(self, action: #selector(registeringMyselfTapped), for: .touchUpInside)
        
        registeringChildButton.setTitle("Registering for My Child", for: .normal)
        registeringChildButton.topAnchor.constraint(equalTo: registeringMyselfButton.bottomAnchor, constant: 100).isActive = true
        registeringChildButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registeringChildButton.addTarget(self, action: #selector(registeringChildTapped), for: .touchUpInside)
    }
    
    @objc func registeringMyselfTapped() {
        let nextViewController = swipeVC()
        manager?.beginApplication()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func registeringChildTapped() {
        let nextViewController = parentLogInVC()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc private func logout() {
        // clear the user session (example only, not for the production)
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        AppDelegate.shared.rootViewController.switchToLogout()
        // navigate to the Main Screen
    }

}
