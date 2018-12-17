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

class lilitabVC: UIViewController {
    
    var manager: libraryCardManager?
    var lilitab = LilitabSDK.singleton()
    let doneButton = nextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(cancelButton, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: styleGuide.colors.whiteSecondary, NSAttributedStringKey.font: UIFont(name: "RobotoSlab-Regular", size: 18)!], for: .normal)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.whiteSecondary
        
        self.title = "Please Swipe Card"
    }
    
    @objc func swipeTapped() {
        let nextViewController = contactVC()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    @objc func cancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
