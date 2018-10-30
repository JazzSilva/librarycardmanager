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
    
    let swipeCardButton = selectionButton()
    let manuallyEnterButton = selectionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(swipeCardButton)
        view.addSubview(manuallyEnterButton)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        swipeCardButton.setTitle("Swipe Card", for: .normal)
        swipeCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swipeCardButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        swipeCardButton.addTarget(self, action: #selector(swipeTapped), for: .touchUpInside)
        
        manuallyEnterButton.setTitle("Manually Enter my Information", for: .normal)
        manuallyEnterButton.topAnchor.constraint(equalTo: swipeCardButton.bottomAnchor, constant: 100).isActive = true
        manuallyEnterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        manuallyEnterButton.addTarget(self, action: #selector(manuallyEnterTapped), for: .touchUpInside)
        
    }
    
    @objc func swipeTapped() {
        let nextViewController = contactVC()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func manuallyEnterTapped() {
        let nextViewController = manualEntryVC()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
