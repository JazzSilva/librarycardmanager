//
//  patronModel.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/22/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation

class Patron {

    func submitData() {
        print("submitted data to this address")
    }
    
    static var identifierFactory = 0
    
    var identifier: Int
    var cardnumber: String?
    var type: String?
    var status: String?
    var didSwipe: Bool? = false
    
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var birthday: String?
    var phone: String?
    var email: String?
    
    var pin: String?
    var codeWord: String?
    
    var address: String?
    var address1: String?
    var zip: String?
    var state: String?
    var neighborhood: String?
    var locality: String?
    var county: String?
    
    var isGuardian: Bool? = false
    var children: [String?] = []
    
    var contactPreference: String?
    var license: String?
    var signature: Bool?
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Patron.getUniqueIdentifier()
        //later can pass in dictionary of key:value pairs from organization settings
    }
}
