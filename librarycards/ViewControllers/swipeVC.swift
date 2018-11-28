//
//  swipeVC.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/25/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

class swipeVC: UIViewController {
    
    var manager: libraryCardManager?
    let swipeCardButton = selectionButton()
    let manuallyEnterButton = selectionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(swipeCardButton)
        view.addSubview(manuallyEnterButton)
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = styleGuide.colors.whiteSecondary
        
        self.title = "Sign-Up Method"
        swipeCardButton.setTitle("Swipe my ID/License", for: .normal)
        swipeCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swipeCardButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        swipeCardButton.addTarget(self, action: #selector(swipeTapped), for: .touchUpInside)
        
        manuallyEnterButton.setTitle("Manually Enter my Information", for: .normal)
        manuallyEnterButton.topAnchor.constraint(equalTo: swipeCardButton.bottomAnchor, constant: 100).isActive = true
        manuallyEnterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        manuallyEnterButton.addTarget(self, action: #selector(manuallyEnterTapped), for: .touchUpInside)
        
    }
    
    @objc func swipeTapped() {
        let nextViewController = contactVC()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func manuallyEnterTapped() {
        let nextViewController = manualEntryVC()
        nextViewController.manager = self.manager
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func cancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
