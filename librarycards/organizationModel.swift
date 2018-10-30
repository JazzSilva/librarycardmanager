//
//  organizationModel.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/23/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation

class Organization {
    
    static var identifierFactory = 0
    
    var identifier: Int
    var publicName: String?
    var patronProfile: String?
    var networkProfile: String?
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(name: String) {
        self.publicName = name
        self.identifier = Organization.getUniqueIdentifier()
    }
}
