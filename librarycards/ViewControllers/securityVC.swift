//
//  securityVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class securityVC: UIViewController, buttonDelegate {
    
    var manager: libraryCardManager?
    let pinTextField = formTextField()
    let codeWordTextField = formTextField()
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pinTextField)
        view.addSubview(codeWordTextField)
        view.addSubview(doneButton)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
        self.title = "Security"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(cancelButton, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.whiteSecondary
        
        pinTextField.formDelegate = self.manager
        pinTextField.isSecureTextEntry = true
        pinTextField.tag = 9
        pinTextField.keyboardType = .numberPad
        if (self.manager?.activePatron?.pin != nil && self.manager?.activePatron?.pin != "") {
            pinTextField.text = self.manager?.activePatron?.pin
        }
        else {
            pinTextField.placeholder = "4 Digit Pin"
        }
        pinTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pinTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        
        codeWordTextField.formDelegate = self.manager
        codeWordTextField.tag = 10
        if (self.manager?.activePatron?.codeWord != nil && self.manager?.activePatron?.codeWord != "") {
            codeWordTextField.text = self.manager?.activePatron?.codeWord
        }
        else {
            codeWordTextField.placeholder = "Mother's Maiden Name"
        }
        codeWordTextField.topAnchor.constraint(equalTo: pinTextField.bottomAnchor, constant: 50).isActive = true
        codeWordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
    }
    
    func onButtonTapped() {
        let nextViewController = responseVC()
        nextViewController.manager = self.manager
        manager?.activePatron?.pin = pinTextField.text
        manager?.activePatron?.codeWord = codeWordTextField.text
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func cancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
