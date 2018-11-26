//
//  responseVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class responseVC: UIViewController, buttonDelegate, SSRadioButtonControllerDelegate {
    
    var manager: libraryCardManager?
    var radioButtonController: SSRadioButtonsController?
    let agreeButton = SSRadioButton()
    let disagreeButton = SSRadioButton()
    let termsLabel = UILabel()
    
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(doneButton)
        view.addSubview(agreeButton)
        view.addSubview(disagreeButton)
        view.addSubview(termsLabel)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
        manager?.printPatron()
        radioButtonController = SSRadioButtonsController(buttons: agreeButton, disagreeButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.setRightBarButton(cancelButton, animated: true)
        
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.text = "I agree to sign my library card and accept financial responsibility for all items checked out on my library card."
        termsLabel.isUserInteractionEnabled = false
        termsLabel.textColor = .red
        termsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        termsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        
        agreeButton.isSelected = .init(false)
        agreeButton.formatButton(title: "I agree")
        agreeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        agreeButton.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 100).isActive = true
        agreeButton.addTarget(self, action: #selector(didSelect), for: .touchUpInside)
        
        disagreeButton.isSelected = .init(true)
        disagreeButton.formatButton(title: "I do not agree")
        disagreeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        disagreeButton.topAnchor.constraint(equalTo: agreeButton.bottomAnchor, constant: 50).isActive = true
        disagreeButton.addTarget(self, action: #selector(didSelect), for: .touchUpInside)
        
        radioButtonController = SSRadioButtonsController(buttons: agreeButton, disagreeButton)
        radioButtonController?.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        doneButton.isEnabled = false
        doneButton.backgroundColor = styleGuide.colors.grayPrimary
        doneButton.setTitle("Submit", for: .normal)
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
    }
    
    func onButtonTapped() {
        ///TODO: Need to replace this with a proper unwind/log out segue
        let nextViewController = selectMainVC()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func cancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func didSelect() {
        let currentButton = radioButtonController?.selectedButton()
        if currentButton?.title(for: .normal) != "I agree" {
            self.doneButton.isEnabled = true
            doneButton.backgroundColor = styleGuide.colors.greenAccent
            doneButton.isOpaque = true
            manager?.activePatron?.signature = true
            manager?.printPatron()
        }
        else {
            //Change this later to default contact preference from user defaults
            self.doneButton.isEnabled = false
            doneButton.backgroundColor = styleGuide.colors.grayPrimary
            doneButton.isOpaque = false
            manager?.activePatron?.signature = false
            manager?.printPatron()
        }
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        print(selectedButton)
    }
    
}
