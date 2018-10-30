//
//  libraryCardModel.swift
//  librarycards
//
//  Created by Jasmin Silva on 10/22/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation

class libraryCardManager {
    
    var patron: Patron?
    
    //This is our patron queue. It is used primarily for adding children to the same parent application.
    var patronQueue = [Patron]()
    
    func beginApplication() {
        //Create a patron and add them to our patron queue
        self.patron = Patron()
        patronQueue.append(self.patron!)
    }
    
    func submitApplication() {
        // TODO: Submit all patron applications in queue
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
        patronQueue.append(childPatron)
    }
    
    func getPatronData() {
        //Lookup a patron and assign them to our class

    }
    
}
