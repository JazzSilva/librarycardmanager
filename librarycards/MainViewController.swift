//
//  MainViewController.swift
//  librarycards
//
//  Created by Jasmin Silva on 11/1/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray // to visually distinguish the protected part
        let logoutButton = UIBarButtonItem(title: "Staff", style: .plain, target: self, action: #selector(logout))
        navigationItem.setLeftBarButton(logoutButton, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @objc
    private func logout() {
        // clear the user session (example only, not for the production)
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        AppDelegate.shared.rootViewController.switchToLogout()
        // navigate to the Main Screen
    }
}
