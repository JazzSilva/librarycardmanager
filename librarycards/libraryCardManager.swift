//
//  libraryCardModel.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/22/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import Firebase

class libraryCardManager: formUpdateDelegate {
    
    //This is our patron queue. It is used primarily for adding children to the same parent application.
    var patronQueue = [Patron]()
    var activePatron: Patron?
    var childCounter = 0
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    
    func beginApplication() {
        //Create a patron and add them to our patron queue
        self.activePatron = Patron()
        patronQueue.append(activePatron!)
    }
    
    func submitApplication() {
        ref = db.collection("users").addDocument(data: [
            "first": activePatron?.firstName,
            "middle": activePatron?.middleName,
            "last": activePatron?.lastName,
            "email": activePatron?.email,
            "address": activePatron?.address,
            "address1": activePatron?.address1,
            "state": activePatron?.state,
            "neighborhood": activePatron?.neighborhood,
            "county": activePatron?.county,
            "zip": activePatron?.zip,
            "contactPreference": activePatron?.contactPreference,
            "pin": activePatron?.pin,
            "code": activePatron?.codeWord,
            "signature": activePatron?.signature
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref?.documentID ?? "default doc ID")")
            }
        }
    }
    
    func removeApplication() {
        // TODO: Remove a patrons from the queue
    }
    
    func emptyQueue() {
        // TODO: Empty all patrons from the queue
    }
    
    func addChild() {
        // TODO: Add a child to the patronQueue
        let childPatron = Patron()
        childCounter += 1
        patronQueue.append(childPatron)
    }
    
    func getPatronData() {
        //Lookup a patron and assign them to our class
    }
    
    func printPatron() {
        for patron in patronQueue {
            print("First Name: \(patron.firstName ?? "")", "Middle Name: \(patron.middleName ?? "")", "Last Name: \(patron.lastName ?? "")", "Birthday: \(patron.birthday ?? NSDate())", "Phone: \(patron.phone ?? "")", "Email: \(patron.email ?? "")", "Address: \(patron.address ?? "")","Address1: \(patron.address1 ?? "")","Locality: \(patron.locality ?? "")","State: \(patron.state ?? "")","Neighborhood: \(patron.neighborhood ?? "")","County: \(patron.county ?? "")", "Zip: \(patron.zip ?? "")","Contact Preference: \(patron.contactPreference ?? "")","Pin: \(patron.pin ?? "")", "Code: \(patron.codeWord ?? "")", "Signature: \(patron.signature ?? false)")
        }
    }
    
}
