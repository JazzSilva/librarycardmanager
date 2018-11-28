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
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [styleGuide.colors.aquaPrimary?.cgColor, styleGuide.colors.navyPrimary?.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        setGradient()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let userDefaults = UserDefaults.standard
        let branchName = userDefaults.string(forKey: "branch_name") ?? "Harris County Public Library"
        
        let logoutButton = UIBarButtonItem(title: "Staff", style: .plain, target: self, action: #selector(logout))
        logoutButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(logoutButton, animated: true)
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = styleGuide.colors.navyPrimary
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.layer.shadowColor = styleGuide.colors.grayPrimary?.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 2.6
        navigationController?.navigationBar.layer.shadowOpacity = 1.0
        navigationController?.navigationBar.layer.masksToBounds = false
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.whiteSecondary
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: styleGuide.colors.whitePrimary,
             NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Bold", size: 36)!]
        
        self.title = branchName
        
        registeringMyselfButton.setTitle("Registering for Myself", for: .normal)
        registeringMyselfButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registeringMyselfButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
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
        manager?.beginApplication()
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

extension UIViewController {
   
}
