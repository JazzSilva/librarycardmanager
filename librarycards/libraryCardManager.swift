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
            "first": activePatron?.firstName as Any,
            "middle": activePatron?.middleName as Any,
            "last": activePatron?.lastName as Any,
            "email": activePatron?.email as Any,
            "address": activePatron?.address as Any,
            "address1": activePatron?.address1 as Any,
            "state": activePatron?.state as Any,
            "neighborhood": activePatron?.neighborhood as Any,
            "county": activePatron?.county as Any,
            "zip": activePatron?.zip as Any,
            "contactPreference": activePatron?.contactPreference as Any,
            "pin": activePatron?.pin as Any,
            "code": activePatron?.codeWord as Any,
            "signature": activePatron?.signature as Any,
            "guardian": activePatron?.isGuardian as Any,
            "children": activePatron?.children as Any
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
        childCounter += 1
    }
    
    func getPatronData() {
        //Lookup a patron and assign them to our class
    }
    
    func printPatron() {
        for patron in patronQueue {
            print("First Name: \(patron.firstName ?? "")", "Middle Name: \(patron.middleName ?? "")", "Last Name: \(patron.lastName ?? "")", "Birthday: \(patron.birthday ?? NSDate())", "Phone: \(patron.phone ?? "")", "Email: \(patron.email ?? "")", "Address: \(patron.address ?? "")","Address1: \(patron.address1 ?? "")","Locality: \(patron.locality ?? "")","State: \(patron.state ?? "")","Neighborhood: \(patron.neighborhood ?? "")","County: \(patron.county ?? "")", "Zip: \(patron.zip ?? "")","Contact Preference: \(patron.contactPreference ?? "")","Pin: \(patron.pin ?? "")", "Patron Children: \(patron.children)", "Code: \(patron.codeWord ?? "")", "Signature: \(patron.signature ?? false)", "Guardian: \(patron.isGuardian ?? false)")
        }
    }
    
}
