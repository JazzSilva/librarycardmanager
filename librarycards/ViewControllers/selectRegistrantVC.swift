//
//  selectRegistrantVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class selectRegistrantVC: UIViewController {
    
    var manager: libraryCardManager?
    let registeringMyselfButton = selectionButton()
    let registeringChildButton = selectionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(registeringMyselfButton)
        view.addSubview(registeringChildButton)
        manager?.printPatron()
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.setRightBarButton(cancelButton, animated: true)
        
        registeringMyselfButton.setTitle("Registering for Myself", for: .normal)
        registeringMyselfButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registeringMyselfButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
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
    
    @objc func cancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
