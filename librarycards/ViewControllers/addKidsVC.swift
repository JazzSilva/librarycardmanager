//
//  addKidsVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class addKidsVC: UIViewController, buttonDelegate {
    
    var manager: libraryCardManager?
    let addKidsButton = selectionButton()
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addKidsButton)
        view.addSubview(doneButton)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager?.printPatron()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        addKidsButton.setTitle("Add Kids", for: .normal)
        addKidsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addKidsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        addKidsButton.addTarget(self, action: #selector(addKidsTapped), for: .touchUpInside)
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
    }
    
    @objc func addKidsTapped() {
        let nextViewController = contactVC()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func onButtonTapped() {
        let nextViewController = securityVC()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
