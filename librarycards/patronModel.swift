//
//  patronModel.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/22/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation

class Patron {
    
    func didUpdateData(dataType: String, data: String) {
        self.myDict.updateValue(data, forKey: dataType)
        printData()
    }
    
    func printData() {
        for (key, values) in self.myDict {
            print(key, values)
        }
    }
    
    func submitData() {
        print("submitted data to this address")
    }
    
    var myDict: [String: String?] = [
        "firstName": nil,
        "middleName": nil,
        "lastName": nil,
        "phoneNumber": nil,
        "email": nil,
        "address": nil,
        "city": nil,
        "state": nil,
        "zip": nil
    ]
    
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
        //later can pass in dictionary of key:value pairs from organization settings
    }
}
