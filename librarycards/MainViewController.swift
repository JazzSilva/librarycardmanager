//
//  MainViewController.swift
//  librarycards
//
//  Created by Jasmin Silva on 11/1/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

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
        // navigate to the Main Screen
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        AppDelegate.shared.rootViewController.switchToLogout()
    }
}
