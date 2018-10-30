//
//  securityVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class Security: UIViewController, buttonDelegate {
    
    let pinTextField = formTextField()
    let codeWordTextField = formTextField()
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(pinTextField)
        view.addSubview(codeWordTextField)
        view.addSubview(doneButton)
        doneButton.delegate = self
        setupLayout()
    }
    
    private func setupLayout() {
        pinTextField.placeholder = "Pin Number"
        pinTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pinTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true

        codeWordTextField.placeholder = "Code Word"
        codeWordTextField.topAnchor.constraint(equalTo: pinTextField.bottomAnchor, constant: 100).isActive = true
        codeWordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    func onButtonTapped() {
        let nextViewController = Response()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
