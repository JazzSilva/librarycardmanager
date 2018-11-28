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
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        self.title = "Child Information"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.pinkSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(cancelButton, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.aquaPrimary
        
        formatTextField(childTextField)
        childTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        var constant = (32 * ((self.manager?.childCounter)! * 2)) + 100
        childTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(constant)).isActive = true
        
        addKidsButton.setTitle("Add Another Child", for: .normal)
        addKidsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addKidsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        addKidsButton.addTarget(self, action: #selector(addAnotherChild), for: .touchUpInside)
        
        doneButton.titleLabel?.text = "Done"
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        doneButton.delegate = self
    }
    
    @objc func doneTapped() {
        let nextViewController = contactVC()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func addAnotherChild() {
        if self.manager?.childCounter == 4 {
            let alert = UIAlertController(title: "Sorry!", message: "You can only register four children at once.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
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
        textField.placeholder = "First Last"
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
        //let nextViewController = securityVC()
        //nextViewController.manager = self.manager
        //navigationController?.pushViewController(nextViewController, animated: true)
        _=getAllTextFields(fromView : self.view).map{($0.text = "Hey dude!")}
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
