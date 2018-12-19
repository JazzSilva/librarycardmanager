//
//  lilitabVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 12/10/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit
import LilitabSDK
import PopupDialog

class lilitabVC: UIViewController, buttonDelegate {
    
    var manager: libraryCardManager?
    var lilitab = LilitabSDK.singleton()
    var userDict = Dictionary<Int, String>()
    //var userInformation = Dictionary<String, [String]>()
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(doneButton)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
        lilitab?.scanForConnectedAccessories()
        lilitab?.enableSwipe = true
        lilitab?.swipeTimeout = 0
        lilitab?.allowMultipleSwipes = false
        lilitab?.ledState = LilitabSDK_LED_Mode.LED_On
        lilitab?.swipeBlock = { (_ swipeData: Any?) -> Void in
            self.swipeFunc(swipeData)
            self.lilitab?.ledState = LilitabSDK_LED_Mode.LED_Blink2
        }
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
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(cancelButton, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.whiteSecondary
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        doneButton.delegate = self
        
        self.title = "Please Swipe Card"
    }
    
    @objc func cancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func onButtonTapped() {
        let nextViewController = contactVC()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func swipeFunc(_ swipeData: Any?) -> Void {
        //Put the data from the ID into a dictionary
        if let swipeData = swipeData as! [String:Any]? {
            let data = swipeData["rawData"] as! String
            
            var i = 0
            //Parse raw data into a dictionary where an index (1-4) corresponds to each field separator (^)
            for items in data.components(separatedBy: "^") {
                i = i + 1
                self.userDict[i] = items
            }
            
            do {
                //Use regular expressions to parse each of the 4 track lines to get each field
                guard let city = self.userDict[1],
                    let name = self.userDict[2],
                    let address = self.userDict[3],
                    let zip = self.userDict[4]
                    else {
                        //This is the popup that should appear for a failed swipe
                        let successImage = UIImage(named: "sorryIcon")
                        let popUpTwo = PopupDialog(title: "Whoops!", message: "We couldn't read your card. If your ID is damaged, you may need to manually enter your information.", image: successImage)
                        let dialogAppearance = PopupDialogDefaultView.appearance()
                        dialogAppearance.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
                        dialogAppearance.messageFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
                        let buttonTwo = DefaultButton(title: "Manually enter my information") {
                            print("Manually enter information")
                            let nextViewController = manualEntryVC()
                            nextViewController.manager = self.manager
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                        buttonTwo.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
                        let buttonOne = CancelButton(title: "Try swiping again") {
                            print("You canceled the swipe.")
                        }
                        buttonOne.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
                        popUpTwo.addButtons([buttonOne, buttonTwo])
                        // Present dialog
                        self.present(popUpTwo, animated: true, completion: nil)
                        //self.animateUnableToReadSwipeView()
                        return
                    }
                self.cityState(input: city)
                self.name(input: name)
                self.addressInput(input: address)
                self.zipDobNumber(input: zip)
                //Create popup of successful swipe
                
                let successImage = UIImage(named: "successIcon")
                let popUp = PopupDialog(title: "Great job!", message: "Press continue to enter your contact information.", image: successImage)
                let dialogAppearance = PopupDialogDefaultView.appearance()
                dialogAppearance.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
                dialogAppearance.messageFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
                
                let buttonTwo = DefaultButton(title: "Continue", height: 60) {
                    print("Continue to the next screen")
                    self.onButtonTapped()
                }
                buttonTwo.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
                let buttonOne = CancelButton(title: "Cancel") {
                    self.lilitab?.enableSwipe = true
                    print("You canceled the swipe.")
                }
                buttonOne.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
                popUp.addButtons([buttonOne, buttonTwo])
                // Present dialog
                self.present(popUp, animated: true, completion: nil)
            }
            
            //newLibraryCard.fourteenDigitLicense = self.userInformation["DL Number"]?.first!
            //Need to update workflow in twilio for checking if account exists
            //self.animateSuccessfulSwipeView()
        }
        else {
            //If the swipe cannot read the card data, trigger this function
            //self.animateUnableToReadSwipeView()
            let errorImage = UIImage(named: "sorryIcon")
            let popUpTwo = PopupDialog(title: "Whoops!", message: "We couldn't read your card. If your ID is damaged, you may need to manually enter your information.", image: errorImage)
            let dialogAppearance = PopupDialogDefaultView.appearance()
            dialogAppearance.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            dialogAppearance.messageFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            let buttonTwoError = DefaultButton(title: "Manually enter my information") {
                print("Manually enter information")
                let nextViewController = manualEntryVC()
                nextViewController.manager = self.manager
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            buttonTwoError.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            let buttonOneError = CancelButton(title: "Try swiping again") {
                print("You canceled the swipe.")
            }
            buttonOneError.titleFont = UIFont(name: "RobotoSlab-Regular", size: 18)!
            popUpTwo.addButtons([buttonOneError, buttonTwoError])
            // Present dialog
            self.present(popUpTwo, animated: true, completion: nil)
            //self.animateUnableToReadSwipeView()
        }
    }
    
    func cityState(input :String) {
        //userInformation["State"] = input.capturedGroups(withRegex: "[%](..)[.]*")
        manager?.activePatron?.state = input.capturedGroups(withRegex: "[%](..)[.]*").first
        //userInformation["City"] = input.capturedGroups(withRegex: "[%]..(.*)")
        manager?.activePatron?.locality = input.capturedGroups(withRegex: "[%]..(.*)").first
    }
    
    func name(input :String) {
        manager?.activePatron?.lastName = input.capturedGroups(withRegex: "([^$].*)[$]").first
        manager?.activePatron?.firstName = input.capturedGroups(withRegex: "[^$].*[$](.*)$*").first
        manager?.activePatron?.didSwipe = true
        //userInformation["Last"] = input.capturedGroups(withRegex: "([^$].*)[$]")
        //userInformation["First"] = input.capturedGroups(withRegex: "[^$].*[$](.*)$*")
    }
    
    func addressInput(input: String) {
        //userInformation["Address 1"] = [input]
        manager?.activePatron?.address1 = input
    }
    
    func zipDobNumber(input: String) {
        //userInformation["Zip"] = input.capturedGroups(withRegex: "[?][#]..([0-9][0-9][0-9][0-9][0-9])")
        //userInformation["DL Number"] = input.capturedGroups(withRegex: "[?][;]([0-9]*)[=]")
        //userInformation["DOB"] = input.capturedGroups(withRegex: "[=]....([0-9]*)[?]")
        manager?.activePatron?.zip = input.capturedGroups(withRegex: "[?][#]..([0-9][0-9][0-9][0-9][0-9])").first
        manager?.activePatron?.license = input.capturedGroups(withRegex: "[?][;]([0-9]*)[=]").first
        manager?.activePatron?.birthday = input.capturedGroups(withRegex: "[=]....([0-9]*)[?]").first
    }

    
    
}
