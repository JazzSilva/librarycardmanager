//
//  addKidsVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class addKidsVC: UIViewController, buttonDelegate {
    
    var manager: libraryCardManager?
    let addKidsButton = selectionButton()
    let doneButton = nextButton()
    let childTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addKidsButton)
        view.addSubview(doneButton)
        view.addSubview(childTextField)
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

        self.title = "Child Information"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(cancelButton, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.whiteSecondary
        
        formatTextField(childTextField)
        childTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        var constant = (32 * ((self.manager?.childCounter)! * 2)) + 100
        childTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(constant)).isActive = true
        
        addKidsButton.setTitle("Add Another Child", for: .normal)
        addKidsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addKidsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170).isActive = true
        addKidsButton.addTarget(self, action: #selector(addAnotherChild), for: .touchUpInside)
        
        doneButton.titleLabel?.text = "Done"
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
    }
    
    @objc func addAnotherChild() {
        if self.manager?.childCounter == 4 {
            let sorryImage = UIImage(named: "sorryIcon")
            let popUp = PopupDialog(title: "Sorry!", message: "You can only register four children at once.", image: sorryImage)
            let dialogAppearance = PopupDialogDefaultView.appearance()
            dialogAppearance.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            dialogAppearance.messageFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            
            let buttonOne = CancelButton(title: "Okay") {
                print("User pressed okay.")
            }
            buttonOne.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            popUp.addButtons([buttonOne])
            
            // Present dialog
            self.present(popUp, animated: true, completion: nil)
        }
        else
        {
        self.manager?.addChild()
        let textBox = UITextField()
        formatTextField(textBox)
        view.addSubview(textBox)
        textBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        var constant = (32 * ((self.manager?.childCounter)! * 2)) + 100
        textBox.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(constant)).isActive = true
        }
    }
    
    func formatTextField(_ textField: UITextField) {
        textField.placeholder = "First and Last Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = styleGuide.colors.whitePrimary
        textField.textColor = styleGuide.colors.grayPrimary
        textField.font = UIFont(name: "RobotoSlab-Regular", size: 18.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 500).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.clearButtonMode = .unlessEditing
        textField.keyboardType = .namePhonePad
        textField.enablesReturnKeyAutomatically = true
    }
    
    func onButtonTapped() {
        if (childTextField.text?.isEmpty)! {
            let sorryImage = UIImage(named: "sorryIcon")
            let popUp = PopupDialog(title: "Sorry!", message: "You must add at least one child.", image: sorryImage)
            let dialogAppearance = PopupDialogDefaultView.appearance()
            dialogAppearance.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            dialogAppearance.messageFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            
            let buttonOne = CancelButton(title: "Okay") {
                print("User pressed okay.")
            }
            buttonOne.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            popUp.addButtons([buttonOne])
            
            // Present dialog
            self.present(popUp, animated: true, completion: nil)
        }
        else {
            let nextViewController = securityVC()
            nextViewController.manager = self.manager
            manager?.printPatron()
            navigationController?.pushViewController(nextViewController, animated: true)
            _=getAllTextFields(fromView : self.view).map{self.manager?.activePatron?.children.append($0.text!)}
        }
    }
    
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.flatMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
    }
    
    @objc func cancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
