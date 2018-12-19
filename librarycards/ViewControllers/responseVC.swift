//
//  responseVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import PopupDialog

class responseVC: UIViewController, buttonDelegate, SSRadioButtonControllerDelegate {
    
    var manager: libraryCardManager?
    var radioButtonController: SSRadioButtonsController?
    let agreeButton = SSRadioButton()
    let disagreeButton = SSRadioButton()
    let doneButton = nextButton()
    let termsLabel = UILabel()
    
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
        
        self.title = "Review and Submit"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(cancelButton, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.whiteSecondary
        
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.text = "I agree to sign my library card and accept financial responsibility for all items checked out on my library card."
        termsLabel.font = UIFont(name: "RobotoSlab-Regular", size: 22)
        termsLabel.isUserInteractionEnabled = false
        termsLabel.adjustsFontSizeToFitWidth = true
        termsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        termsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        termsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        termsLabel.textColor = styleGuide.colors.whitePrimary
        termsLabel.textAlignment = .center
        termsLabel.lineBreakMode = .byWordWrapping
        termsLabel.numberOfLines = 2
        termsLabel.minimumScaleFactor = 0.5
        
        agreeButton.isSelected = .init(false)
        agreeButton.formatButton(title: "I agree")
        agreeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        agreeButton.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 30).isActive = true
        agreeButton.addTarget(self, action: #selector(didSelect), for: .touchUpInside)
        
        disagreeButton.isSelected = .init(true)
        disagreeButton.formatButton(title: "I do not agree")
        disagreeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        disagreeButton.topAnchor.constraint(equalTo: agreeButton.bottomAnchor, constant: 30).isActive = true
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
        manager?.submitApplication()
        if manager?.activePatron?.didSwipe == false && manager?.activePatron?.isGuardian == true {
            //This popUp will display when a parent has registered a child
            let completeImage = UIImage(named: "completeIcon")
            let popUp = PopupDialog(title: "Thank You", message: "Please visit the front desk to pick up your children's library card(s).", image: completeImage)
            let dialogAppearance = PopupDialogDefaultView.appearance()
            dialogAppearance.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            dialogAppearance.messageFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            
            let buttonOne = CancelButton(title: "Okay") {
                self.cancel()
                print("User pressed okay.")
            }
            buttonOne.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            popUp.addButtons([buttonOne])
            // Present dialog
            self.present(popUp, animated: true, completion: nil)
    
        }
        else if manager?.activePatron?.didSwipe == false && manager?.activePatron?.isGuardian == false {
            //This popUp will display when a parent has registered a child
            let completeImage = UIImage(named: "completeIcon")
            let popUp = PopupDialog(title: "Thank You", message: "Please visit the front desk to pick up your library card.", image: completeImage)
            let dialogAppearance = PopupDialogDefaultView.appearance()
            dialogAppearance.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            dialogAppearance.messageFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            
            let buttonOne = CancelButton(title: "Okay") {
                self.cancel()
                print("User pressed okay.")
            }
            buttonOne.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            popUp.addButtons([buttonOne])
            // Present dialog
            self.present(popUp, animated: true, completion: nil)
        }
        else {
            //This popUp will display when a parent has registered a child
            let completeImage = UIImage(named: "completeIcon")
            let popUp = PopupDialog(title: "Thank You", message: "You may now use your license to checkout materials.", image: completeImage)
            let dialogAppearance = PopupDialogDefaultView.appearance()
            dialogAppearance.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            dialogAppearance.messageFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            let buttonOne = CancelButton(title: "Okay") {
                self.cancel()
                print("User pressed okay.")
            }
            buttonOne.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            popUp.addButtons([buttonOne])
            // Present dialog
            self.present(popUp, animated: true, completion: nil)
        }
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
