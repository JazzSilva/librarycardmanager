//
//  SplashViewController.swift
//  librarycards
//
//  Created by Jasmin Silva on 11/1/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        setupLayout()
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            self.activityIndicator.stopAnimating()
            if Auth.auth().currentUser != nil {
                AppDelegate.shared.rootViewController.switchToMainScreen()
                // navigate to protected page
            } else {
                AppDelegate.shared.rootViewController.switchToLogout()
                // navigate to login screen
            }
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor.white
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
    }
    
    
}
