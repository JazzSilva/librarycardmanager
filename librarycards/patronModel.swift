//
//  patronModel.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/22/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation

struct Patron {
    
    static var identifierFactory = 0
    
    var identifier: Int
    var cardnumber: String?
    var type: String?
    var status: String?
    
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var birthday: NSDate?
    var phone: String?
    var email: String?
    
    var address: String?
    var city: String?
    var state: String?
    var zip: String?
    
    var license: String?
    var signature: Bool?
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Patron.getUniqueIdentifier()
    }
}
